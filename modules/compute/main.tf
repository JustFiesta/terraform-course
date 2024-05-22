resource "aws_instance" "tf-tmp-instance" {
  ami           = "ami-0ac67a26390dc374d"
  instance_type = "t3.micro"
  user_data     = var.user_data
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sec_group_id]

  tags = merge(var.common_tags, { Name = "tf-tmp-instance" })
}

# Create image from tmp instance
resource "aws_ami_from_instance" "tf-ami-tmp-instance" {
  name               = "tf-ami-tmp-instance"
  source_instance_id = aws_instance.tf-tmp-instance.id

  tags = merge(var.common_tags, { Name = "tf-ami-tmp-instance" })
}

# Create autoscaling group
resource "aws_autoscaling_group" "tf-asg" {
  desired_capacity     = 3
  max_size             = 3
  min_size             = 3
  vpc_zone_identifier  = [var.subnet_id]
  launch_template {
    id      = aws_launch_template.tf-launch-template.id
    version = "$Latest"
  }

  tags = [
    for key, value in merge(var.common_tags, { Name = "tf-auto-scaling-group" }) : {
      key                 = key
      value               = value
      propagate_at_launch = true
    }
  ]
}

# Launch VM's
resource "aws_launch_template" "tf-launch-template" {
  name_prefix   = "tf-launch-template"
  image_id      = aws_ami_from_instance.tf-ami-tmp-instance.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [var.sec_group_id]
  
  tags = merge(var.common_tags, { Name = "tf-launch-template" })
}

# Create Application Load Balancer
resource "aws_lb" "tf-lb" {
  name               = "tf-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sec_group_id]
  subnets            = [var.subnet_id]
  tags = merge(var.common_tags, { Name = "tf-lb" })
}

# Create health check target group
resource "aws_lb_target_group" "tf-tg" {
  name     = "tf-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
    health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
  tags = merge(var.common_tags, { Name = "tf-target-group" })
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
  tags = merge(var.common_tags, { Name = "tf-listener" })
}