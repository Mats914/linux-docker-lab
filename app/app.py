# =============================================================================
# app.py
# -----------------------------------------------------------------------------
# A Python application that runs inside a Docker container and reports
# information about the current runtime environment.
#
# Purpose:
#   - Demonstrate that a Python app can be packaged and executed inside Docker
#   - Inspect container-level environment variables and system metadata
#   - Serve as a testable baseline for more complex containerized applications
#
# Usage:
#   docker build -t linux-lab .
#   docker run --rm linux-lab
#   docker run --rm -e ENV=production linux-lab
# =============================================================================

import os
import platform
import socket
import sys
from datetime import datetime, timezone


def get_env_info() -> dict:
    """
    Collect runtime environment metadata from the container.

    Returns:
        dict: A mapping of label -> value for each environment attribute:
            - hostname     : Container hostname (assigned by Docker)
            - os           : Operating system name (e.g. 'Linux')
            - os_release   : Kernel release version
            - python       : Python interpreter version
            - environment  : Value of the ENV variable (from docker-compose or -e flag)
            - user         : User running the current process
    """
    return {
        "hostname":    socket.gethostname(),        # Docker assigns a random short hash
        "os":          platform.system(),            # 'Linux' inside the container
        "os_release":  platform.release(),           # Kernel version string
        "python":      platform.python_version(),    # e.g. '3.10.12'
        "environment": os.getenv("ENV", "unknown"),  # Injected via ENV variable
        "user":        os.getenv("USER", "appuser"), # Current OS user
    }


def print_banner(title: str) -> None:
    """
    Print a formatted section banner to stdout.

    Args:
        title: The text to display inside the banner.
    """
    border = "=" * 44
    print(border)
    print(f"  {title}")
    print(border)


def print_info_table(data: dict) -> None:
    """
    Print a key-value table with consistent column alignment.

    Each key is left-aligned in a fixed-width column so values
    line up neatly regardless of key length.

    Args:
        data: Dictionary of string labels and their corresponding values.
    """
    for key, value in data.items():
        # :<16 pads the key to 16 characters, left-aligned
        print(f"  {key:<16} {value}")


def print_timestamp() -> None:
    """Print the current UTC timestamp — useful for log correlation."""
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")
    print(f"  {'started_at':<16} {now}")


# =============================================================================
# Entry point
# =============================================================================
if __name__ == "__main__":
    env_info = get_env_info()

    print_banner("🐳  Linux & Docker Lab — Container Info")
    print_info_table(env_info)
    print_timestamp()
    print("=" * 44)
    print("  ✅  Application completed successfully.")
    print("=" * 44)

    # Exit with code 0 to signal clean execution to Docker / CI
    sys.exit(0)
