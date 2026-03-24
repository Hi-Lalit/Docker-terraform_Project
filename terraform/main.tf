resource "aws_instance" "docker_ec2" {
  ami           = var.ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name

  subnet_id = aws_subnet.docker_subnet.id

  vpc_security_group_ids = [aws_security_group.docker_sg.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "DockerWebApps"
  }
}