resource "aws_instance" "tf-tmp-instance" {
  ami           = "ami-0ac67a26390dc374d"
  instance_type = "t3.micro"
  user_data     = var.user_data
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [var.sec_group_id]

  tags = merge(var.common_tags, { Name = "tf-tmp-instance" })
}

# Create image from tmp instance
resource "aws_ami_from_instance" "tf-ami-tmp-instance" {
  name               = "tf-ami-tmp-instance"
  source_instance_id = aws_instance.tf-tmp-instance.id

  depends_on         = [aws_instance.tf-tmp-instance]

  tags = merge(var.common_tags, { Name = "tf-ami-tmp-instance" })
}

resource "aws_launch_configuration" "tf-webserver-lc" {
  name          = "webserver-lc"
  image_id      = aws_ami_from_instance.tf-ami-tmp-instance.id
  instance_type = "t3.micro"

  tags = merge(var.common_tags, { Name = "tf-launch-template" })
}

# Create autoscaling group
resource "aws_autoscaling_group" "tf-asg" {
  desired_capacity     = 3
  max_size             = 3
  min_size             = 3
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.tf-webserver-lc.id

  tag {
    key                 = "Owner"
    value               = "mbocak"
    propagate_at_launch = true
  }
  tag {
    key                 = "Project"
    value               = "Internship_DevOps"
    propagate_at_launch = true
  }
  tag {
    key                 = "Name"
    value               = "tf-asg"
    propagate_at_launch = true
  }
}
