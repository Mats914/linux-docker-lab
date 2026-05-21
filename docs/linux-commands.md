# Linux Command Reference

Essential commands used in this lab.

## Navigation
```bash
pwd                     # Print working directory
ls -la                  # List all files with details
cd /path/to/dir         # Change directory
mkdir -p dir/subdir     # Create nested directories
```

## Files & Permissions
```bash
chmod +x script.sh      # Make script executable
chmod 755 file          # rwxr-xr-x permissions
cp -r src/ dest/        # Copy recursively
rm -rf dir/             # Remove directory (careful!)
find . -name "*.py"     # Search for files
```

## Docker Commands
```bash
docker build -t name .  # Build image from Dockerfile
docker run --rm name    # Run & remove after exit
docker run -it name sh  # Interactive shell
docker ps -a            # List all containers
docker images           # List images
docker exec -it ID sh   # Shell into running container
docker logs ID          # View container logs
docker system prune     # Free up disk space
docker-compose up       # Start all services
docker-compose down     # Stop all services
```

## System Info
```bash
uname -a                # Kernel and OS info
df -h                   # Disk usage
free -h                 # RAM usage
top                     # Process monitor (q to quit)
ps aux                  # List all running processes
```

## Git Basics
```bash
git init                # Initialize repo
git add .               # Stage all changes
git commit -m "msg"     # Commit with message
git push origin main    # Push to remote
```
