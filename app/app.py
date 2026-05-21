# =============================================================================
# app.py
# -----------------------------------------------------------------------------
# A simple Python application that runs inside a Docker container and prints
# information about the current runtime environment.
#
# Purpose:
#   - Demonstrate that a Python app can be packaged and executed inside Docker
#   - Inspect container-level environment variables and system metadata
#   - Serve as a baseline for more complex containerized applications
#
# Usage:
#   docker build -t linux-lab .
#   docker run --rm linux-lab
# =============================================================================

import os
import platform
import socket


def get_env_info() -> dict:
    """
    Collect runtime environment metadata from the container.

    Returns a dictionary with:
      - hostname     : The container's hostname (auto-assigned by Docker)
      - os           : Operating system name (e.g. Linux)
      - os_release   : Kernel release version
      - python       : Python interpreter version
      - environment  : Value of the ENV variable (set in docker-compose.yml)
      - user         : Current user running the process
    """
    return {
        "hostname":    socket.gethostname(),       # Docker assigns a random hostname
        "os":          platform.system(),           # Should be 'Linux' inside the container
        "os_release":  platform.release(),          # Kernel version
        "python":      platform.python_version(),   # Python version installed in the image
        "environment": os.getenv("ENV", "unknown"), # Injected via docker-compose ENV
        "user":        os.getenv("USER", "root"),   # Current system user
    }


def print_banner(title: str) -> None:
    """Print a formatted section banner to stdout."""
    border = "=" * 42
    print(border)
    print(f"  {title}")
    print(border)


def print_info_table(data: dict) -> None:
    """
    Print a key-value table with consistent column alignment.

    Args:
        data: Dictionary of labels and their corresponding values
    """
    for key, value in data.items():
        # Left-align the key in a 14-character column for readability
        print(f"  {key:<14} {value}")


# =============================================================================
# Entry point
# =============================================================================
if __name__ == "__main__":
    env_info = get_env_info()

    print_banner("🐳  Running inside Docker Container")
    print_info_table(env_info)
    print("=" * 42)
    print("  ✅  Application ran successfully.")
    print("=" * 42)
