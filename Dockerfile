# =============================================================================
# Dockerfile
# -----------------------------------------------------------------------------
# Defines the Docker image for the Linux & Docker Lab project.
#
# Build:   docker build -t linux-lab .
# Run:     docker run --rm linux-lab
# Test:    docker run --rm -v "$PWD/tests:/tests" linux-lab python3 -m pytest /tests/ -v
#
# Base OS: Ubuntu 22.04 LTS (Jammy Jellyfish)
# =============================================================================

# --- Base image --------------------------------------------------------------
# Ubuntu 22.04 LTS is stable, widely used in production, and mirrors
# real Linux server environments closely.
FROM ubuntu:22.04

# --- Image metadata ----------------------------------------------------------
# Visible via: docker inspect linux-lab
LABEL maintainer="your-email@example.com"
LABEL description="Linux & Docker personal lab — containerized Python environment"
LABEL version="1.0"

# --- Build-time environment --------------------------------------------------
# DEBIAN_FRONTEND=noninteractive prevents apt from halting on user prompts.
ENV DEBIAN_FRONTEND=noninteractive

# --- System dependencies -----------------------------------------------------
# All apt commands are chained in one RUN layer to:
#   1. Minimize the number of image layers (smaller image)
#   2. Prevent stale package list caching between layers
# Cleanup at the end removes the apt cache from the final image.
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# --- Non-root user -----------------------------------------------------------
# Running as root inside a container is a security risk.
# We create a dedicated app user and switch to it for all subsequent steps.
RUN useradd --create-home --shell /bin/bash appuser
USER appuser

# --- Working directory --------------------------------------------------------
# All COPY, RUN, and CMD instructions execute relative to /app.
WORKDIR /app

# --- Python dependencies -----------------------------------------------------
# requirements.txt is copied first (before source code) to exploit Docker's
# layer cache: if only source code changes, pip install is skipped entirely.
COPY --chown=appuser:appuser app/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# --- Application source ------------------------------------------------------
# Copy the rest of the app into the container's working directory.
COPY --chown=appuser:appuser app/ .

# --- Runtime environment variable --------------------------------------------
# Default value for ENV; can be overridden with: docker run -e ENV=production
ENV ENV=development

# --- Default command ---------------------------------------------------------
# Exec form (JSON array) is preferred over shell form because it:
#   - Sends signals (SIGTERM) directly to the Python process
#   - Does not spawn an extra /bin/sh process
CMD ["python3", "app.py"]
