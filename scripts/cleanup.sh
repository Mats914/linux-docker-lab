#!/usr/bin/env bash
# =============================================================================
# cleanup.sh
# -----------------------------------------------------------------------------
# Removes Docker resources created by the Linux & Docker Lab project.
#
# Removes:
#   - Containers started via docker-compose
#   - The 'linux-lab' Docker image
#   - Dangling images, stopped containers, and unused networks
#
# Usage:
#   ./scripts/cleanup.sh           # Standard cleanup
#   ./scripts/cleanup.sh --all     # Also removes ALL unused Docker resources
#
# Note: '|| true' is used where failure is acceptable (e.g. resource not found).
# =============================================================================

set -euo pipefail

DEEP_CLEAN=false

for arg in "$@"; do
  case "$arg" in
    --all) DEEP_CLEAN=true ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

section() {
  echo
  echo "  ── $1"
}

ok()   { echo "  ✅  $1"; }
info() { echo "  ℹ️   $1"; }

echo
echo "  ╔══════════════════════════════════════════╗"
echo "  ║   Linux & Docker Lab — Cleanup           ║"
echo "  ╚══════════════════════════════════════════╝"

# --- Step 1: Stop Compose services -------------------------------------------
section "Stopping docker-compose services"

# 'docker compose down' stops containers AND removes them plus their networks.
# Redirecting stderr + '|| true' prevents failure if Compose was never started.
docker compose down 2>/dev/null || true
ok "Compose services stopped"

# --- Step 2: Remove the lab image --------------------------------------------
section "Removing 'linux-lab' image"

if docker image inspect linux-lab &>/dev/null 2>&1; then
  docker rmi linux-lab
  ok "Image removed"
else
  info "Image 'linux-lab' not found — nothing to remove"
fi

# --- Step 3: Prune dangling resources ----------------------------------------
section "Pruning dangling Docker resources"

# Removes:
#   - Stopped containers
#   - Unused networks
#   - Dangling images (layers with no tag and no parent image)
#   - Dangling build cache
# -f skips the interactive confirmation prompt
docker image prune -f
ok "Dangling images pruned"

# --- Step 4: Deep clean (optional) -------------------------------------------
if [ "$DEEP_CLEAN" = true ]; then
  section "Deep clean — removing ALL unused Docker resources"
  echo "  ⚠️   WARNING: This removes ALL unused images on this machine,"
  echo "       not just those from this project."
  echo
  # 'docker system prune -f' is intentionally scoped here.
  # Use with caution if other Docker projects are running on the same machine.
  docker system prune -f
  ok "Full system prune complete"
fi

# --- Done --------------------------------------------------------------------
echo
echo "  ╔══════════════════════════════════════════╗"
echo "  ║   ✅  Cleanup complete.                  ║"
echo "  ╚══════════════════════════════════════════╝"
echo
