resource "aws_instance" "tf-tmp-instance" {
  ami           = "ami-0ac67a26390dc374d"
  instance_type = "t3.micro"
  user_data     = var.user_data
  
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sec_group_id]

  tags = merge(var.common_tags, { Name = "tf-tmp-instance" })

  lifecycle {
    create_before_destroy = true
  }
}

# Create image from tmp instance
resource "aws_ami_from_instance" "tf-ami-tmp-instance" {
  name               = "tf-ami-tmp-instance"
  source_instance_id = aws_instance.tf-tmp-instance.id

  tags = merge(var.common_tags, { Name = "tf-ami-tmp-instance" })
}
