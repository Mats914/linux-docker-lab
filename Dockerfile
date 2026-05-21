# Base image — Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Maintainer label
LABEL maintainer="your-email@example.com"
LABEL description="Linux & Docker personal lab environment"

# Prevent interactive prompts during package install
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install essentials
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /app

# Copy requirements first (layer caching optimization)
COPY app/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy application source
COPY app/ .

# Default command
CMD ["python3", "app.py"]
