#!/usr/bin/env bash
# =============================================================================
# cleanup.sh
# -----------------------------------------------------------------------------
# Removes all Docker resources created by the Linux & Docker Lab project.
#
# What this script removes:
#   - Running containers started via docker-compose
#   - The 'linux-lab' Docker image
#   - Dangling images, stopped containers, and unused networks (docker prune)
#
# Usage:
#   chmod +x scripts/cleanup.sh     # Make executable (only needed once)
#   ./scripts/cleanup.sh            # Run from project root
#
# Note:
#   This script uses '|| true' in several places to prevent the script from
#   exiting when a resource doesn't exist (e.g. image already deleted).
# =============================================================================

set -euo pipefail

echo "=============================================="
echo "   Linux & Docker Lab — Cleanup"
echo "=============================================="
echo

# --- Step 1: Stop Compose services -------------------------------------------
# 'docker compose down' stops and removes containers, networks, and volumes
# defined in docker-compose.yml.
# '2>/dev/null || true' suppresses errors if Compose was never started.
echo "  ==> Stopping docker-compose services..."
docker compose down 2>/dev/null || true
echo "  ✅ Compose services stopped"

# --- Step 2: Remove the lab Docker image -------------------------------------
# We built this image in setup.sh with the tag 'linux-lab'.
# '2>/dev/null || true' prevents errors if the image was never built.
echo
echo "  ==> Removing 'linux-lab' Docker image..."
docker rmi linux-lab 2>/dev/null || echo "  ℹ️  Image 'linux-lab' not found — skipping"
echo "  ✅ Image removed"

# --- Step 3: Prune unused Docker resources ------------------------------------
# 'docker system prune -f' removes:
#   - All stopped containers
#   - All networks not used by at least one container
#   - All dangling images (untagged layers with no parent)
#   - All dangling build cache
#
# The -f (force) flag skips the confirmation prompt.
# WARNING: This affects ALL Docker resources on the system, not just this project.
echo
echo "  ==> Pruning unused Docker system resources..."
docker system prune -f
echo "  ✅ System pruned"

# --- Done --------------------------------------------------------------------
echo
echo "=============================================="
echo "  ✅ Cleanup complete. All lab resources removed."
echo "=============================================="
