resource "aws_security_group" "main" {
  name   = "${var.project_name}-lb-sg-${var.environment}"
  vpc_id = module.vpc.vpc_id

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