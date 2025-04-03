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

resource "aws_launch_template" "dev_instance" {
  count = var.environment == "dev" ? 1 : 0

  name          = "${var.project_name}-template-${var.environment}"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = var.instance_user_data

  key_name = var.key_name

  network_interfaces {
    security_groups = var.instance_security_group_ids
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.instance_tags
    )
  }
}

resource "aws_launch_template" "prod_instance" {
  count = var.environment == "prod" ? 1 : 0

  name          = "${var.project_name}-template-${var.environment}"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = var.instance_user_data

  network_interfaces {
    security_groups = var.instance_security_group_ids
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.instance_tags
    )
  }
}
