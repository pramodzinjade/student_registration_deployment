#

terraform {
  backend "s3" {
    bucket = "terraform-s3bucket007"
    key = "ubuntunewkey"
    region = "us-east-1"
  }
}

provider "aws" {
 region = "us-east-1"
}

resource "aws_vpc" "student-vpc" {
  cidr_block = var.vpc-cidr_block
  tags = {
    Name = "student_vpc"
  }
}

resource "aws_subnet" "target-subnet" {
  vpc_id = aws_vpc.student-vpc.id
  cidr_block = var.subnet-cidr_block
  availability_zone = var.availibility-zone
  map_public_ip_on_launch = true
  tags = {
    Name = "target_subnet"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.student-vpc.id
  tags = {
    Name = "student IGT"
  }
  
}
resource "aws_default_route_table" "default-route-table" {
  default_route_table_id = aws_vpc.student-vpc.default_route_table_id
  tags = {
    Name: "default route table"
  }
}
resource "aws_route" "target-route" {
route_table_id = aws_vpc.student-vpc.default_route_table_id
destination_cidr_block = var.IGW-cidr
gateway_id = aws_internet_gateway.internet-gateway.id
}
resource "aws_security_group" "student-sg" {
  vpc_id = aws_vpc.student-vpc.id
  tags = {
    Name = "student-security"
  }

  ingress  {
    description = "allow ssh"
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "allow nginx"
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    description = "allow jenkins"
    to_port = 8080
    from_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all"
    to_port = 0
    from_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "target-server" {
  subnet_id = aws_subnet.target-subnet.id
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.student-sg.id]
  availability_zone = var.availibility-zone
  tags = {
    Name = "web-server"
  }
}