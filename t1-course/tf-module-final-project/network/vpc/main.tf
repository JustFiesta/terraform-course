resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = "${var.project_name}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count = var.number_of_subnets

  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index + var.number_of_subnets)

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index}"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  count = var.number_of_subnets

  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index)

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
    Environment = var.environment
  }
}

resource "aws_security_group" "main" {
  name   = "${var.project_name}-lb-sg-${var.environment}"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-lb-sg-${var.environment}"
  }
}