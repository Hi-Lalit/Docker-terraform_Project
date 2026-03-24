# Security Group
resource "aws_security_group" "docker_sg" {
  name        = "docker-sg"
  description = "Allow SSH, HTTP, custom ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "docker_ec2" {
  ami             = var.ami_id # Ubuntu 22.04 LTS
  instance_type   = var.ec2_instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.docker_sg.name]

  user_data = <<-EOF
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
                if [ ! -d /home/ubuntu/Docker-project ]; then
                    git clone https://github.com/Hi-Lalit/Docker_Project.git /home/ubuntu/Docker-project
                fi

                # Move into project directory
                cd /home/ubuntu/Docker-project

                # Start Docker containers
                docker-compose up -d
              EOF

  tags = {
    Name = "DockerWebApps"
  }
}