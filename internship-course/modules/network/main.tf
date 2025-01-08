# Create VPC
resource "aws_vpc" "this" {
  cidr_block        = "172.16.0.0/16"
}

# Create Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

# Create subnets for VPC
resource "aws_subnet" "tf_a" {
  vpc_id = aws_vpc.this.id
  cidr_block = "${var.tf_a_sub}"
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "tf_b" {
  vpc_id = aws_vpc.this.id
  cidr_block = "${var.tf_b_sub}"
  availability_zone = "${var.region}b"
}

# Create secirity group for VPC
resource "aws_security_group" "tf_ssh_http" {
  name              = "tf_ssh_http"
  description       = "Allow SSH, HTTP rule"

  vpc_id            = aws_vpc.this.id
  depends_on        = [aws_vpc.this]
}

# Create and attach security rules
resource "aws_vpc_security_group_ingress_rule" "tf_ssh" {
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.tf_ssh_http.id

  depends_on        = [aws_security_group.tf_ssh_http]
}

resource "aws_vpc_security_group_ingress_rule" "tf_http" {
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.tf_ssh_http.id
  
  depends_on        = [aws_security_group.tf_ssh_http]
}

resource "aws_eip" "tf_public" {
  vpc = true
}

# Create Application Load Balancer
resource "aws_lb" "this" {
  name               = "this"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf_ssh_http.id]
  subnets            = [aws_subnet.tf-a.id, aws_subnet.tf-b.id]
}

# Create health check target group
resource "aws_lb_target_group" "this" {
  name     = "tf_primary_group"
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
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = ${var.lb_port}
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
