# Create VPC
resource "aws_vpc" "tf-vpc" {
  cidr_block        = "172.16.0.0/16"

  tags = merge(var.common_tags, { Name = "tf-vpc" })
}

# Create subnets for VPC
resource "aws_subnet" "tf-subnet-a" {
  vpc_id = aws_vpc.tf-vpc.id
  cidr_block = "172.16.10.0/24"
  availability_zone = "${var.region}a"
  tags = merge(var.common_tags, { Name = "tf-subnet-a" })
}

resource "aws_subnet" "tf-subnet-b" {
  vpc_id = aws_vpc.tf-vpc.id
  cidr_block = "172.16.20.0/24"
  availability_zone = "${var.region}b"
  tags = merge(var.common_tags, { Name = "tf-subnet-b" })
}

# Create secirity group for VPC
resource "aws_security_group" "tf-sec-group" {
  name              = "tf-sec-group"
  description       = "Allow SSH, HTTP rule"

  vpc_id            = aws_vpc.tf-vpc.id
  depends_on        = [aws_vpc.tf-vpc]

  tags = merge(var.common_tags, { Name = "tf-sec-group" })
}

# Create and attach security rules
resource "aws_security_group_rule" "tf-ssh_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tf-sec-group.id

  depends_on        = [aws_security_group.tf-sec-group]
}

resource "aws_security_group_rule" "tf-http_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tf-sec-group.id
  
  depends_on        = [aws_security_group.tf-sec-group]
}

resource "aws_eip" "tf-public-ip" {
  vpc = true

  tags = merge(var.common_tags, { Name = "tf-public-ip" })
}
