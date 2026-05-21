#!/usr/bin/env bash
# cleanup.sh — Remove containers and images from this lab
set -euo pipefail
echo "==> Stopping running containers..."
docker compose down 2>/dev/null || true
echo "==> Removing linux-lab image..."
docker rmi linux-lab 2>/dev/null || echo "   (image not found, skipping)"
echo "==> Pruning unused Docker resources..."
docker system prune -f
echo "✅ Cleanup done."
