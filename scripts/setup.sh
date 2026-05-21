#!/usr/bin/env bash
# =============================================================================
# setup.sh
# -----------------------------------------------------------------------------
# Bootstrap script for the Linux & Docker Lab environment.
#
# What this script does:
#   1. Checks that Docker is installed and the daemon is running
#   2. Builds the Docker image from the project Dockerfile
#   3. Runs a hello-world container to verify Docker connectivity
#   4. Runs the lab application inside the built container
#
# Usage:
#   chmod +x scripts/setup.sh     # Make executable (only needed once)
#   ./scripts/setup.sh            # Run from project root
#
# Requirements:
#   - Docker Engine 20+
#   - Bash 4+
# =============================================================================

# Strict mode:
#   -e  exit immediately if any command fails
#   -u  treat unset variables as errors
#   -o pipefail  catch errors in piped commands (e.g. cmd1 | cmd2)
set -euo pipefail

# =============================================================================
# Helper functions
# =============================================================================

# Print a formatted section header
section() {
  echo
  echo "──────────────────────────────────────────"
  echo "  $1"
  echo "──────────────────────────────────────────"
}

# Print a success message
ok() { echo "  ✅ $1"; }

# Print an error message and exit
fail() { echo "  ❌ $1"; exit 1; }

# =============================================================================
# Main script
# =============================================================================

echo "=============================================="
echo "   Linux & Docker Lab — Environment Setup"
echo "=============================================="

# --- Step 1: Check Docker installation ----------------------------------------
section "Checking dependencies"

# 'command -v docker' returns a non-zero exit code if docker isn't in PATH
if ! command -v docker &>/dev/null; then
  fail "Docker not found. Install it from: https://docs.docker.com/get-docker/"
fi

# Extract and display Docker version for confirmation
DOCKER_VERSION=$(docker --version | cut -d' ' -f3 | tr -d ',')
ok "Docker $DOCKER_VERSION is installed"

# --- Step 2: Check Docker daemon is running -----------------------------------
# 'docker info' fails if the daemon isn't running (e.g. Docker Desktop is closed)
if ! docker info &>/dev/null; then
  fail "Docker daemon is not running. Please start Docker and try again."
fi
ok "Docker daemon is active"

# --- Step 3: Build the Docker image -------------------------------------------
section "Building Docker image: linux-lab"

# The dot (.) tells Docker to use the current directory as the build context.
# -t linux-lab assigns a name (tag) to the image.
docker build -t linux-lab .
ok "Image built successfully"

# --- Step 4: Verify Docker works with hello-world ----------------------------
section "Running connectivity test (hello-world)"

# --rm automatically removes the container after it exits.
# This is good practice to avoid accumulating stopped containers.
docker run --rm hello-world
ok "hello-world test passed"

# --- Step 5: Run the lab application ------------------------------------------
section "Running linux-lab application"

docker run --rm linux-lab
ok "Application ran successfully"

# --- Done --------------------------------------------------------------------
echo
echo "=============================================="
echo "  ✅ Setup complete! Next steps:"
echo ""
echo "     docker run --rm linux-lab"
echo "     docker-compose up --build"
echo "     ./scripts/cleanup.sh   (when done)"
echo "=============================================="
