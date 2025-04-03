resource "aws_autoscaling_group" "asg" {
  name                 = "${var.project_name}-asg-${var.environment}"
  min_size             = 3
  max_size             = 5
  desired_capacity     = 3
  vpc_zone_identifier  = var.public_subnets
  target_group_arns    = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.instance.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "instance" {
  name          = "${var.project_name}-template-${var.environment}"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = var.instance_user_data

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.instance_tags
    )
  }
}
