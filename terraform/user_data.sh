#!/bin/bash
set -e  # Exit if any command fails

# Update package index
apt update -y

# Install Docker, Docker Compose, and Git
apt install -y docker.io docker-compose git

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Clone your repo if it doesn’t exist
if [ ! -d /home/ubuntu/Docker-terraform_Project ]; then
    git clone -b main https://github.com/Hi-Lalit/Docker-terraform_Project.git /home/ubuntu/Docker-terraform_Project
fi
# Move into project directory
cd /home/ubuntu/Docker-terraform_Project/app

# Start Docker containers
docker-compose up -d