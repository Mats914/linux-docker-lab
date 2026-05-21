# 🐧 Linux & Docker Lab

![Linux](https://img.shields.io/badge/Linux-Ubuntu_22.04-E95420?logo=ubuntu&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-24+-2496ED?logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnu-bash&logoColor=white)
![WSL](https://img.shields.io/badge/WSL2-Ubuntu-0078D4?logo=windows&logoColor=white)

A hands-on personal lab for practicing Linux system administration and Docker containerization.  
Built from scratch to develop and document real terminal skills relevant to infrastructure and DevOps roles.

---

## 📋 What This Project Covers

| Skill | Description |
|---|---|
| **Linux CLI** | File system navigation, permissions, process management |
| **Bash scripting** | Automation scripts with error handling and strict mode |
| **Docker** | Building images, running containers, layer caching |
| **Docker Compose** | Multi-service orchestration and environment configuration |
| **Git** | Version control, repository structure, commit discipline |

---

## 📁 Project Structure

```
linux-docker-lab/
├── README.md                  # Project overview and documentation
├── Dockerfile                 # Container image definition (Ubuntu 22.04 + Python)
├── docker-compose.yml         # Service orchestration configuration
├── .gitignore                 # Excluded files (secrets, cache, venv)
│
├── app/
│   ├── app.py                 # Python app — prints container environment info
│   └── requirements.txt       # Python dependencies (pinned versions)
│
├── scripts/
│   ├── setup.sh               # Bootstrap: checks deps, builds image, runs tests
│   └── cleanup.sh             # Teardown: removes containers, images, and prunes system
│
└── docs/
    └── linux-commands.md      # Personal Linux & Docker command reference sheet
```

---

## 🚀 Quick Start

### Prerequisites
- [Docker Desktop](https://docs.docker.com/get-docker/) or Docker Engine 20+
- Git
- Ubuntu 22.04 (or WSL2 on Windows)

### 1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/linux-docker-lab.git
cd linux-docker-lab
```

### 2. Run the setup script
```bash
chmod +x scripts/*.sh
./scripts/setup.sh
```

The script will automatically:
- Verify Docker is installed and running
- Build the Docker image
- Run a connectivity test
- Launch the application inside a container

---

## 🐳 Docker Usage

```bash
# Build the image manually
docker build -t linux-lab .

# Run the container (auto-removed after exit)
docker run --rm linux-lab

# Run interactively (explore the container filesystem)
docker run --it --rm linux-lab bash

# Use Docker Compose
docker-compose up --build          # Start services
docker-compose up -d               # Run in background
docker-compose logs -f app         # Stream logs
docker-compose down                # Stop and remove containers
```

---

## 🧹 Cleanup

```bash
./scripts/cleanup.sh
```

Removes the built image, stops Compose services, and prunes unused Docker resources.

---

## 🛠 Skills Demonstrated

- **Linux environment**: Worked in Ubuntu 22.04 via WSL2 with a focus on terminal-based development
- **Bash scripting**: Written scripts with `set -euo pipefail`, error handling, and helper functions
- **Docker images & containers**: Built custom images, managed container lifecycle, applied layer caching
- **Docker Compose**: Configured multi-service environments with volumes and environment variables
- **Git discipline**: Structured repository with meaningful commits and proper `.gitignore`

---

## 📚 References

- [Docker Documentation](https://docs.docker.com/)
- [Ubuntu WSL2 Setup Guide](https://docs.microsoft.com/en-us/windows/wsl/)
- [Bash Strict Mode](http://redsymbol.net/articles/unofficial-bash-strict-mode/)

---

*Built on Ubuntu 22.04 via WSL2 · Docker Engine 24+*
