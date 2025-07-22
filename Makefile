# Makefile for Ollama and Open WebUI

.PHONY: all up up-gpu up-cpu down clean logs pull init help

# Default target: show help
all: help

# Initialize base Ollama container and pull llama2 model
init:
	@echo "Starting base Ollama container (if not already running)..."
	docker compose up -d ollama
	@echo "Waiting for Ollama server to become ready..."
	@until curl -s http://localhost:11434/api/tags > /dev/null; do \
		echo "Waiting for Ollama to respond..."; \
		sleep 1; \
	done
	@echo "Pulling model: llama2..."
	docker exec ollama ollama pull llama2
	@echo "✅ Model llama2 is installed and ready to use."

# Smart start: try GPU (ollama), fallback to CPU (ollama-cpu)
up:
	@echo "Ensuring no conflicting Ollama containers are running..."
	docker compose down --remove-orphans || true
	sleep 2
	@echo "Detecting NVIDIA GPU..."
	@if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi >/dev/null 2>&1; then \
		docker compose up -d ollama open-webui; \
	else \
		docker compose --profile cpu up -d ollama-cpu open-webui; \
	fi
	@echo "Services started. Access Open WebUI at http://localhost:3000"

# Start services with GPU support (if NVIDIA drivers/toolkit are installed)
up-gpu:
	@echo "Attempting to start Ollama and Open WebUI with GPU support..."
	docker compose --profile gpu up -d
	@echo "Services started. Access Open WebUI at http://localhost:3000"

# Start services with CPU-only support
up-cpu:
	@echo "Starting Ollama and Open WebUI with CPU-only support..."
	docker compose --profile cpu up -d
	@echo "Services started. Access Open WebUI at http://localhost:3000"

# Stop all services
down:
	@echo "Stopping Ollama and Open WebUI services..."
	docker compose down

# Stop and remove all services and volumes (CAUTION: deletes all data!)
clean:
	@echo "Stopping and removing all services and volumes. This will delete all data!"
	docker compose down -v

# View logs
logs:
	@echo "Viewing logs (press Ctrl+C to exit)..."
	docker compose logs -f

# Pull latest Docker images
pull:
	@echo "Pulling latest Docker images..."
	docker compose pull

# Help menu
help:
	@echo ""
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@echo "  up         : Smart start - attempts GPU, falls back to CPU."
	@echo "  up-gpu     : Start Ollama and Open WebUI with GPU support."
	@echo "  up-cpu     : Start Ollama and Open WebUI with CPU-only support."
	@echo "  down       : Stop all running services."
	@echo "  clean      : Stop and remove all services and volumes (deletes all data!)."
	@echo "  logs       : View real-time logs for all services."
	@echo "  pull       : Pull latest Docker images."
	@echo "  init       : Start Ollama CPU and pull llama2 model."
	@echo ""
