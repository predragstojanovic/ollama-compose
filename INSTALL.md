# Installation Guide

This document outlines the steps to set up your environment for running Ollama and Open WebUI, specifically focusing on Windows with WSL2.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

* **Docker Desktop (Windows/macOS) or Docker Engine (Linux):** Ensure Docker is installed and running. Docker Compose is usually bundled with Docker Desktop or installed separately on Linux.

* **Make:** A build automation tool.

## Setup Instructions

### For Windows Users (with WSL2)

1.  **Enable WSL2 and Virtual Machine Platform:**

    * Press `Windows Key + R` to open the Run dialog.

    * Type `optionalfeatures` and press Enter.

    * In the "Turn Windows features on or off" dialog, ensure "Virtual Machine Platform" and "Windows Subsystem for Linux" are checked.

    * Click "OK" and reboot your system if prompted.

2.  **Install Docker Desktop:**

    * Download Docker Desktop from: `https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe` (or visit `https://www.docker.com/products/docker-desktop/` for the latest version).

    * Run the installer and follow the on-screen instructions.

3.  **Configure Docker Desktop for WSL Integration:**

    * Start Docker Desktop.

    * Go to `Settings` > `Resources` > `WSL Integration`.

    * Ensure your desired WSL distribution (e.g., `Ubuntu`) is enabled.

    * Reboot your system if prompted.

4.  **Validate Docker in WSL:**

    * Open your WSL terminal (e.g., Ubuntu).

    * Run `docker ps -a`.

    * If you encounter permissions errors (e.g., "permission denied while trying to connect to the Docker daemon socket"), run:

        ```bash
        sudo usermod -aG docker $USER
        ```

        Then close and reopen your WSL terminal.

5.  **Install Make in WSL:**

    ```bash
    sudo apt update
    sudo apt install make
    ```

### For Linux/macOS Users (Brief)

For Linux and macOS, follow the official Docker and Make installation guides.

1.  **Install Docker and Docker Compose:** Follow the official Docker documentation for your operating system.

2.  **Install Make:**

    * **Linux:** `sudo apt update && sudo apt install make` (Debian/Ubuntu) or equivalent for your distro.

    * **macOS:** Usually comes with Xcode Command Line Tools. If not, `xcode-select --install`.
