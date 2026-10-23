resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC1"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "igw"
  }
}
resource "aws_subnet" "pubsub" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az
  tags = {
    Name = "sub1"
  }
}
resource "aws_default_route_table" "route" {
  default_route_table_id = aws_vpc.vpc1.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "igw"
  }
}
resource "aws_default_security_group" "sg" {
  vpc_id = aws_vpc.vpc1.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg"
  }
}