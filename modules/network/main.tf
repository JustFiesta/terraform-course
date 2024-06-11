# Create VPC
resource "aws_vpc" "tf-vpc" {
  cidr_block        = "172.16.0.0/16"
}

# Create Internet Gateway
resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id
}

# Create subnets for VPC
resource "aws_subnet" "tf-subnet-a" {
  vpc_id = aws_vpc.tf-vpc.id
  cidr_block = "172.16.10.0/24"
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "tf-subnet-b" {
  vpc_id = aws_vpc.tf-vpc.id
  cidr_block = "172.16.20.0/24"
  availability_zone = "${var.region}b"
}

# Create secirity group for VPC
resource "aws_security_group" "tf-sec-group" {
  name              = "tf-sec-group"
  description       = "Allow SSH, HTTP rule"

  vpc_id            = aws_vpc.tf-vpc.id
  depends_on        = [aws_vpc.tf-vpc]
}

# Create and attach security rules
resource "aws_vpc_security_group_ingress_rule" "tf-ssh_rule" {
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.tf-sec-group.id

  depends_on        = [aws_security_group.tf-sec-group]
}

resource "aws_vpc_security_group_ingress_rule" "tf-http_rule" {
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.tf-sec-group.id
  
  depends_on        = [aws_security_group.tf-sec-group]
}

resource "aws_eip" "tf-public-ip" {
  vpc = true
}

# Create Application Load Balancer
resource "aws_lb" "tf-lb" {
  name               = "tf-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf-sec-group.id]
  subnets            = [aws_subnet.tf-subnet-a.id, aws_subnet.tf-subnet-b.id]
}

# Create health check target group
resource "aws_lb_target_group" "tf-tg" {
  name     = "tf-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
  deregistration_delay = 10
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-299"
  }
}

# Create listener
resource "aws_lb_listener" "tf-listener" {
  load_balancer_arn = aws_lb.tf-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-tg.arn
  }
}
