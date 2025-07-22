# Local LLM with Ollama and Open WebUI

This project provides a simple and efficient way to run large language models (LLMs) locally using [Ollama](https://ollama.com/), with a user-friendly web interface powered by [Open WebUI](https://github.com/open-webui/open-webui). It leverages Docker Compose for easy deployment and includes a Makefile for streamlined management, automatically detecting and utilizing NVIDIA GPUs if available.

## Features

* **Local LLM Hosting:** Run various large language models directly on your machine with Ollama.

* **Web-based Interface:** Interact with your models through a modern and intuitive UI provided by Open WebUI.

* **GPU Acceleration (Conditional):** Automatically attempts to use your NVIDIA GPU for faster inference if detected and configured. Falls back to CPU if no GPU is found.

* **Easy Management:** Use `make` commands to start, stop, clean, and manage your services.

* **Data Persistence:** Models and UI data are persisted across container restarts using Docker volumes.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

* **Docker Desktop (Windows/macOS) or Docker Engine (Linux):** Ensure Docker is installed and running. Docker Compose is usually bundled with Docker Desktop or installed separately on Linux.
    * [Install Docker Desktop](https://www.docker.com/products/docker-desktop/)
    * [Install Docker Engine (Linux)](https://docs.docker.com/engine/install/)
    * [Install Docker Compose](https://docs.docker.com/compose/install/) (if not included with Docker Engine)

* **Make:** A build automation tool.
    * **Linux:** `sudo apt update && sudo apt install make` (Debian/Ubuntu) or equivalent for your distribution.
    * **macOS:** Usually comes with Xcode Command Line Tools. If not, run `xcode-select --install`.

## Usage

To use `make`, navigate to the project root directory in your terminal and run any of the following commands:

* `make init`: Starts the CPU-only Ollama container (`ollama-cpu` service), waits for it to become ready, and then automatically pulls the `llama2` model. This is useful for pre-downloading the model before starting the full stack.
* `make up`: **Smart Start.** Attempts to detect an NVIDIA GPU. If found, starts Ollama and Open WebUI with GPU support (`ollama-gpu` and `open-webui-gpu` services). If no GPU is detected, falls back to CPU-only support (`ollama-cpu` and `open-webui-cpu` services). This command also ensures any conflicting Ollama containers are stopped and removed before starting.
* `make up-gpu`: **Force GPU Start.** Explicitly starts Ollama and Open WebUI with NVIDIA GPU support (activates the `gpu` profile). Use this if you want to ensure GPU is attempted, even if `make up` doesn't detect it automatically.
* `make up-cpu`: **Force CPU Start.** Explicitly starts Ollama and Open WebUI with CPU-only support (activates the `cpu` profile). Use this if you prefer to run on CPU, or if you encounter issues with GPU detection.
* `make down`: Stops all running Ollama and Open WebUI Docker services.
* `make clean`: Stops and removes all Ollama and Open WebUI services, including their associated Docker volumes. **CAUTION: This will permanently delete all your downloaded models and Open WebUI data!**
* `make logs`: Displays real-time logs for all running Ollama and Open WebUI services. Press `Ctrl+C` to exit the log stream.
* `make pull`: Pulls the latest Docker images for Ollama and Open WebUI from their respective registries.
* `make help`: Displays a list of all available `make` commands and their descriptions.