# =============================================================================
# Dockerfile
# -----------------------------------------------------------------------------
# Defines the Docker image for the Linux & Docker Lab project.
#
# Build:   docker build -t linux-lab .
# Run:     docker run --rm linux-lab
#
# Base OS: Ubuntu 22.04 LTS (Jammy Jellyfish)
# =============================================================================

# --- Stage: Base image -------------------------------------------------------
# We use Ubuntu 22.04 LTS as the base because it's stable, widely used in
# production environments, and closely mirrors a real Linux server.
FROM ubuntu:22.04

# --- Image metadata ----------------------------------------------------------
# LABEL instructions add metadata to the image.
# These are visible via: docker inspect linux-lab
LABEL maintainer="your-email@example.com"
LABEL description="Linux & Docker personal lab — containerized Python environment"
LABEL version="1.0"

# --- Environment variables ---------------------------------------------------
# DEBIAN_FRONTEND=noninteractive prevents apt from prompting for user input
# during package installation, which would cause the build to hang.
ENV DEBIAN_FRONTEND=noninteractive

# --- System dependencies -----------------------------------------------------
# We chain all apt commands into a single RUN layer to:
#   1. Keep the image small (fewer intermediate layers)
#   2. Avoid caching stale package lists
# The final rm -rf clears the apt cache to reduce image size.
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# --- Working directory --------------------------------------------------------
# All subsequent commands (COPY, RUN, CMD) will execute relative to /app.
# This is the root of our application inside the container.
WORKDIR /app

# --- Python dependencies -----------------------------------------------------
# We copy requirements.txt BEFORE copying the full source code.
# This is a Docker best practice: if requirements haven't changed, Docker
# reuses the cached pip install layer — speeding up repeated builds.
COPY app/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# --- Application source ------------------------------------------------------
# Copy the rest of the application files into the container's /app directory.
COPY app/ .

# --- Default command ---------------------------------------------------------
# This is the command Docker runs when the container starts.
# Using JSON array format (exec form) is preferred over shell form
# because it avoids spawning an extra shell process.
CMD ["python3", "app.py"]
