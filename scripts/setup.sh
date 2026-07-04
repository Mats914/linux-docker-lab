#!/usr/bin/env bash
# =============================================================================
# setup.sh
# -----------------------------------------------------------------------------
# Bootstrap script for the Linux & Docker Lab environment.
#
# Steps:
#   1. Verify Docker is installed and the daemon is running
#   2. Build the Docker image from the Dockerfile
#   3. Run a hello-world smoke test to verify Docker connectivity
#   4. Run the lab application inside the freshly built container
#   5. (Optional) Run the test suite inside the container
#
# Usage:
#   chmod +x scripts/setup.sh     # Make executable (first time only)
#   ./scripts/setup.sh            # Run from project root
#   ./scripts/setup.sh --test     # Also run the test suite
#
# Requirements:
#   - Docker Engine 20+ or Docker Desktop
#   - Bash 4+
# =============================================================================

# Strict mode:
#   -e  exit on any error
#   -u  treat unset variables as errors
#   -o pipefail  propagate errors through pipes
set -euo pipefail

# =============================================================================
# Configuration
# =============================================================================

IMAGE_NAME="linux-lab"
RUN_TESTS=false   # Set to true with --test flag

# Parse command-line flags
for arg in "$@"; do
  case "$arg" in
    --test) RUN_TESTS=true ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

# =============================================================================
# Helper functions
# =============================================================================

# Print a section divider with a title
section() {
  echo
  echo "  ┌──────────────────────────────────────────┐"
  printf  "  │  %-42s│\n" "$1"
  echo "  └──────────────────────────────────────────┘"
}

ok()   { echo "  ✅  $1"; }
info() { echo "  ℹ️   $1"; }
fail() { echo "  ❌  $1"; exit 1; }

# =============================================================================
# Main
# =============================================================================

echo
echo "  ╔══════════════════════════════════════════╗"
echo "  ║   Linux & Docker Lab — Setup             ║"
echo "  ╚══════════════════════════════════════════╝"

# --- Step 1: Verify Docker installation --------------------------------------
section "Checking dependencies"

if ! command -v docker &>/dev/null; then
  fail "Docker not found. Install it: https://docs.docker.com/get-docker/"
fi

DOCKER_VERSION=$(docker --version | grep -oP '\d+\.\d+\.\d+' | head -1)
ok "Docker $DOCKER_VERSION found"

# Verify Docker daemon is active (fails if Docker Desktop is not running)
if ! docker info &>/dev/null 2>&1; then
  fail "Docker daemon is not running. Please start Docker and retry."
fi
ok "Docker daemon is running"

# --- Step 2: Build the Docker image ------------------------------------------
section "Building image: $IMAGE_NAME"

# The dot (.) sets the build context to the current directory.
# Docker reads the Dockerfile and bundles everything it needs from here.
docker build -t "$IMAGE_NAME" .
ok "Image '$IMAGE_NAME' built"

# Show image size — useful to track bloat over time
IMAGE_SIZE=$(docker image inspect "$IMAGE_NAME" --format='{{.Size}}' | awk '{printf "%.1f MB", $1/1024/1024}')
info "Image size: $IMAGE_SIZE"

# --- Step 3: Smoke test -------------------------------------------------------
section "Smoke test (hello-world)"

# --rm ensures the container is removed after it exits — avoids clutter.
docker run --rm hello-world > /dev/null
ok "Docker connectivity confirmed"

# --- Step 4: Run the application ---------------------------------------------
section "Running: $IMAGE_NAME"

docker run --rm "$IMAGE_NAME"
ok "Application exited cleanly"

# --- Step 5: Run tests (optional) --------------------------------------------
if [ "$RUN_TESTS" = true ]; then
  section "Running test suite"
  docker run --rm \
    -v "$PWD/tests:/tests" \
    "$IMAGE_NAME" \
    python3 -m pytest /tests/ -v --tb=short
  ok "All tests passed"
fi

# --- Done --------------------------------------------------------------------
echo
echo "  ╔══════════════════════════════════════════╗"
echo "  ║   ✅  Setup complete!                    ║"
echo "  ║                                          ║"
echo "  ║   docker run --rm $IMAGE_NAME            ║"
echo "  ║   docker compose up --build              ║"
echo "  ║   ./scripts/setup.sh --test              ║"
echo "  ║   ./scripts/cleanup.sh                   ║"
echo "  ╚══════════════════════════════════════════╝"
echo