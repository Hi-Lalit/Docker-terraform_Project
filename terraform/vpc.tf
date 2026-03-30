# -------------------------------
# VPC
# -------------------------------

data "aws_availability_zones" "available" {}

resource "aws_vpc" "docker_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "docker-vpc"
  }
}

# -------------------------------
# Public Subnet
# -------------------------------
resource "aws_subnet" "docker_subnet" {
  vpc_id                  = aws_vpc.docker_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  availability_zone = data.aws_availability_zones.available.names[0] 

  tags = {
    Name = "docker-public-subnet"
  }
}
# -------------------------------
# Internet Gateway
# -------------------------------
resource "aws_internet_gateway" "docker_igw" {
  vpc_id = aws_vpc.docker_vpc.id

  tags = {
    Name = "docker-igw"
  }
}

# -------------------------------
# Route Table
# -------------------------------
resource "aws_route_table" "docker_rt" {
  vpc_id = aws_vpc.docker_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.docker_igw.id
  }

  tags = {
    Name = "docker-rt"
  }
}

# -------------------------------
# Route Table Association
# -------------------------------
resource "aws_route_table_association" "docker_rta" {
  subnet_id      = aws_subnet.docker_subnet.id
  route_table_id = aws_route_table.docker_rt.id
}