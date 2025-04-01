resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = "${var.project_name}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count = var.subnet_count
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index}"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  count = var.subnet_count
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)

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
