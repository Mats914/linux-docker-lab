# 🐧 Linux & Docker Lab

![Linux](https://img.shields.io/badge/Linux-Ubuntu_22.04-E95420?logo=ubuntu&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-24+-2496ED?logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnu-bash&logoColor=white)

A hands-on personal lab for learning Linux system administration and Docker containerization. Built to demonstrate practical terminal skills, container lifecycle management, and isolated development environment setup.

---

## 📁 Project Structure

```
linux-docker-lab/
├── README.md              # You are here
├── Dockerfile             # Container image definition
├── docker-compose.yml     # Multi-service orchestration
├── .gitignore
├── scripts/
│   ├── setup.sh           # Environment bootstrap
│   └── cleanup.sh         # Clean containers & images
├── app/
│   ├── app.py             # Sample Python app
│   └── requirements.txt
└── docs/
    └── linux-commands.md  # Reference sheet
```

---

## 🚀 Quick Start

```bash
git clone https://github.com/YOUR_USERNAME/linux-docker-lab.git
cd linux-docker-lab
chmod +x scripts/*.sh
./scripts/setup.sh
```

---

## 🐳 Run with Docker

```bash
# Build the image
docker build -t linux-lab .

# Run the container
docker run --rm linux-lab

# Or use Docker Compose
docker-compose up --build
```

---

## 🛠 Skills Demonstrated

- Linux terminal navigation and file system management
- Bash scripting for automation and environment setup
- Docker image building, container lifecycle, and networking
- Isolated dev environment configuration with Docker
- Git workflow and repository management

---

## 📋 Requirements

- Docker Engine 24+
- Ubuntu 22.04 (or WSL2 on Windows)
- Git

---

*Built on Ubuntu 22.04 via WSL2 · Docker Engine 24+*
# linux-docker-lab
