#!/usr/bin/env bash
# setup.sh — Bootstrap the Linux Docker Lab environment
set -euo pipefail
echo "================================================"
echo "  Linux & Docker Lab — Environment Setup"
echo "================================================"
echo
echo "==> Checking dependencies..."
if ! command -v docker &>/dev/null; then
  echo "❌ Docker not found. Install from https://docs.docker.com/get-docker/"
  exit 1
fi
echo "✅ Docker $(docker --version | cut -d' ' -f3 | tr -d ',')"
if ! docker info &>/dev/null; then
  echo "❌ Docker daemon is not running. Please start Docker."
  exit 1
fi
echo "✅ Docker daemon is running"
echo
echo "==> Building Docker image: linux-lab..."
docker build -t linux-lab .
echo
echo "==> Running hello-world test..."
docker run --rm hello-world
echo
echo "==> Running the lab app..."
docker run --rm linux-lab
echo
echo "================================================"
echo "✅ Setup complete!"
echo "   Run:  docker run --rm linux-lab"
echo "   Or:   docker-compose up --build"
echo "================================================"
