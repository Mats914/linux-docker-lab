"""
app.py — Sample Python app running inside a Docker container.
Demonstrates container environment inspection.
"""
import os
import platform
import socket


def get_env_info():
    return {
        "hostname":    socket.gethostname(),
        "os":          platform.system(),
        "os_release":  platform.release(),
        "python":      platform.python_version(),
        "environment": os.getenv("ENV", "unknown"),
        "user":        os.getenv("USER", "root"),
    }


if __name__ == "__main__":
    info = get_env_info()
    print("=" * 40)
    print("  🐳  Running inside Docker container")
    print("=" * 40)
    for key, val in info.items():
        print(f"  {key:<14} {val}")
    print("=" * 40)
    print("  ✅  App ran successfully.")
    print("=" * 40)
