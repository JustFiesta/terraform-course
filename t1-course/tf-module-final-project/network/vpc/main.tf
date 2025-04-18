resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = "${var.project_name}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index + length(var.availability_zones))
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))

  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.project_name}-private-subnet-${count.index}"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))

  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.project_name}-public-subnet-${count.index}"
    Environment = var.environment
  }
}

resource "aws_eip" "nat" {
  count = length(var.availability_zones)

  tags = {
    Name        = "${var.project_name}-nat-eip-${count.index}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "main" {
  count = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name        = "${var.project_name}-nat-${count.index}"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.public]
}

resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
    Environment = var.environment
  }
}

resource "aws_route_table" "public" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name        = "${var.project_name}-private-rt-${count.index}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}