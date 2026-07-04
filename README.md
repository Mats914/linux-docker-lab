# 🐧 Linux & Docker Lab

![CI](https://github.com/YOUR_USERNAME/linux-docker-lab/actions/workflows/ci.yml/badge.svg)
![Linux](https://img.shields.io/badge/Linux-Ubuntu_22.04-E95420?logo=ubuntu&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-24+-2496ED?logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnu-bash&logoColor=white)
![ShellCheck](https://img.shields.io/badge/ShellCheck-passing-brightgreen)

A hands-on personal lab for practicing Linux system administration and Docker containerization —  
built to develop and demonstrate real terminal skills relevant to infrastructure and DevOps roles.

---

## 📋 What This Project Covers

| Area | Skills |
|---|---|
| **Linux CLI** | File system navigation, permissions, process management, I/O redirection |
| **Bash scripting** | Strict mode (`set -euo pipefail`), flag parsing, helper functions, error handling |
| **Docker** | Image builds, layer caching, non-root users, multi-stage thinking |
| **Docker Compose** | Service orchestration, volumes, environment variables, restart policies |
| **Testing** | Python unit tests with `pytest`, tests running inside Docker |
| **CI/CD** | GitHub Actions pipeline — lint → build → test on every push |
| **Git** | Structured commits, `.gitignore`, repository hygiene |

---

## 📁 Project Structure

```
linux-docker-lab/
├── .github/
│   └── workflows/
│       └── ci.yml                 # GitHub Actions: lint → build → test
│
├── app/
│   ├── app.py                     # Python app — inspects container runtime info
│   └── requirements.txt           # Pinned Python dependencies (pytest)
│
├── tests/
│   └── test_app.py                # Unit tests for app.py (pytest)
│
├── scripts/
│   ├── setup.sh                   # Bootstrap: verify, build, run, optional --test
│   └── cleanup.sh                 # Teardown: remove containers, images, prune
│
├── docs/
│   └── linux-commands.md          # Personal Linux & Docker command reference
│
├── Dockerfile                     # Ubuntu 22.04 + Python + non-root user
├── docker-compose.yml             # Service orchestration
└── .gitignore                     # Excludes secrets, cache, venv, logs
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

### 3. Run with tests included
```bash
./scripts/setup.sh --test
```

The setup script will:
- ✅ Verify Docker is installed and the daemon is running
- ✅ Build the Docker image and display its size
- ✅ Run a hello-world connectivity smoke test
- ✅ Launch the application inside the container
- ✅ *(optional)* Execute the full pytest suite inside the container

---

## 🐳 Docker Usage

```bash
# Build the image
docker build -t linux-lab .

# Run the app (container auto-removed after exit)
docker run --rm linux-lab

# Run with a different environment
docker run --rm -e ENV=production linux-lab

# Open an interactive shell inside the container
docker run -it --rm linux-lab bash

# Run tests inside the container
docker run --rm -v "$PWD/tests:/tests" linux-lab python3 -m pytest /tests/ -v

# Use Docker Compose
docker compose up --build           # Build and start
docker compose up -d                # Start in background
docker compose logs -f app          # Stream logs
docker compose down                 # Stop and remove
```

---

## 🧪 Running Tests

Tests are written with `pytest` and run inside the Docker container to ensure they execute in the same environment as the app.

```bash
# Run via setup script
./scripts/setup.sh --test

# Run directly with Docker
docker run --rm -v "$PWD/tests:/tests" linux-lab python3 -m pytest /tests/ -v

# Run locally (requires Python + pytest installed)
pip install pytest
pytest tests/ -v
```

---

## ⚙️ CI/CD Pipeline

Every push to `main` or `develop` triggers the GitHub Actions workflow:

```
push to main
    │
    ├── lint     → ShellCheck on all .sh scripts
    │
    ├── build    → docker build + smoke test (needs: lint)
    │
    └── test     → pytest inside the container (needs: build)
```

See [`.github/workflows/ci.yml`](.github/workflows/ci.yml) for the full pipeline definition.

---

## 🧹 Cleanup

```bash
./scripts/cleanup.sh          # Remove project containers and images
./scripts/cleanup.sh --all    # Also prune ALL unused Docker resources (system-wide)
```

---

## 🛠 Skills Demonstrated

- **Linux environment**: Worked in Ubuntu 22.04 via WSL2 with terminal-based development
- **Bash scripting**: Scripts with strict mode, argument parsing, helper functions, and clear output
- **Docker**: Built images with layer caching, non-root users, and explicit CMD exec form
- **Docker Compose**: Configured volume mounts, environment injection, and restart policies
- **Testing**: Python unit tests covering all public functions, running inside the container
- **CI/CD**: GitHub Actions pipeline with linting, build verification, and automated test execution
- **Git hygiene**: Structured repository, meaningful commits, proper `.gitignore`

---

## 📚 References

- [Docker Documentation](https://docs.docker.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Ubuntu WSL2 Setup](https://docs.microsoft.com/en-us/windows/wsl/)
- [ShellCheck](https://www.shellcheck.net/)
- [Bash Strict Mode](http://redsymbol.net/articles/unofficial-bash-strict-mode/)
- [pytest Documentation](https://docs.pytest.org/)

---

*Built on Ubuntu 22.04 via WSL2 · Docker Engine 24+ · Python 3.10+*
