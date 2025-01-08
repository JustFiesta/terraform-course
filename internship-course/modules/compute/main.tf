resource "aws_instance" "tf_tmp_instance" {
  ami           = "ami-0ac67a26390dc374d"
  instance_type = "t3.micro"
  user_data     = var.user_data
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [var.sec_group_id]
}

# Create image from tmp instance
resource "aws_ami_from_instance" "tf_ami_tmp_instance" {
  name               = "tf_ami_tmp_instance"
  source_instance_id = aws_instance.tf_tmp_instance.id

  depends_on         = [aws_instance.tf_tmp_instance]
}

resource "aws_launch_configuration" "tf_webserver_lc" {
  name          = "webserver_lc"
  image_id      = aws_ami_from_instance.tf_ami_tmp_instance.id
  instance_type = "t3.micro"
}

# Create autoscaling group
resource "aws_autoscaling_group" "tf_scale_3" {
  desired_capacity     = 3
  max_size             = 3
  min_size             = 3
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.tf_webserver_lc.id
}
