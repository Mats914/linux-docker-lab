# Linux & Docker Command Reference

Personal reference sheet — commands used and learned throughout this lab.

---

## Navigation & File System

```bash
# Print the current working directory
pwd

# List files with permissions, size, and timestamps
ls -la

# Change directory
cd /path/to/dir

# Go up one directory level
cd ..

# Go to home directory
cd ~

# Create a directory (and parents if needed)
mkdir -p parent/child/grandchild

# Display a tree view of the directory structure
tree                        # install with: apt install tree
```

---

## File Operations

```bash
# Copy a file
cp source.txt destination.txt

# Copy a directory recursively
cp -r src_dir/ dest_dir/

# Move or rename a file
mv old_name.txt new_name.txt

# Remove a file
rm file.txt

# Remove a directory and all its contents (use with caution!)
rm -rf directory/

# Search for files by name
find . -name "*.py"

# Search for a pattern inside files
grep -r "search_term" .
grep -n "search_term" file.txt    # -n shows line numbers
```

---

## File Permissions

```bash
# Make a script executable
chmod +x script.sh

# Set specific permissions: owner=rwx, group=rx, others=rx
chmod 755 file

# Change file owner and group
chown user:group file

# View permissions in detail
ls -l file.txt
# Output example: -rwxr-xr-x  (owner / group / others)
```

---

## Text & Output

```bash
# Print file contents to terminal
cat file.txt

# View file page by page (q to quit)
less file.txt

# Print first 20 lines of a file
head -n 20 file.txt

# Print last 20 lines, and follow new output (useful for logs)
tail -n 20 -f logfile.txt

# Print a string to terminal
echo "Hello, Linux!"

# Redirect output to a file (overwrites)
echo "content" > file.txt

# Append output to a file
echo "more content" >> file.txt
```

---

## System Information

```bash
# Show kernel name, version, and architecture
uname -a

# Show disk usage in human-readable format
df -h

# Show RAM usage
free -h

# Real-time process monitor (press q to quit)
top

# List all running processes
ps aux

# Show current logged-in user
whoami

# Show system uptime
uptime
```

---

## Docker — Image Management

```bash
# Build an image from the Dockerfile in the current directory
docker build -t my-image-name .

# List all local images
docker images

# Remove an image by name or ID
docker rmi my-image-name

# Remove all dangling (untagged) images
docker image prune

# Pull an image from Docker Hub
docker pull ubuntu:22.04
```

---

## Docker — Container Lifecycle

```bash
# Run a container and remove it automatically when it exits
docker run --rm my-image-name

# Run a container interactively with a shell
docker run -it --rm my-image-name bash

# Run a container in the background (detached mode)
docker run -d --name my-container my-image-name

# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop a running container
docker stop my-container

# Remove a stopped container
docker rm my-container

# View logs from a container
docker logs my-container

# Follow logs in real-time
docker logs -f my-container

# Open a shell inside a running container
docker exec -it my-container bash
```

---

## Docker — Compose

```bash
# Build images and start all services
docker-compose up --build

# Start services in the background
docker-compose up -d

# Stop and remove all containers defined in compose file
docker-compose down

# View logs from a specific service
docker-compose logs -f app

# Rebuild a single service
docker-compose build app
```

---

## Docker — System Maintenance

```bash
# Show disk usage by Docker objects
docker system df

# Remove all unused Docker resources (containers, images, networks, cache)
docker system prune -f

# Remove everything including volumes (careful!)
docker system prune -a --volumes
```

---

## Git Basics

```bash
# Initialize a new Git repository
git init

# Check the status of the working tree
git status

# Stage all changes for commit
git add .

# Stage a specific file
git add filename.txt

# Commit staged changes with a message
git commit -m "feat: add Dockerfile and setup script"

# Show commit history (compact view)
git log --oneline

# Push commits to the remote repository
git push origin main

# Pull latest changes from remote
git pull origin main
```

---

*Reference for Linux & Docker Lab — updated as new commands are learned.*
