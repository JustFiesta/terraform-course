# Create temporary instance with httpd running
resource "aws_instance" "tf-tmp-instance" {
  ami           = "ami-005e54dee72cc1d00"
  instance_type = "t3.micro"
  user_data     = var.user_data
  
  depends_on    = [module.network.vpc_id]
  
  tags = merge(var.common_tags, { Name = "tf-tmp-instance" })

  lifecycle {
    create_before_destroy = true
  }
}

# Create image from tmp instance
resource "aws_ami_from_instance" "tf-ami-tmp-instance" {
  name               = "tf-ami-tmp-instance"
  source_instance_id = aws_instance.tf-tmp-instance.id
  depends_on         = [aws_instance.tf-tmp-instance]

  tags = merge(var.common_tags, { Name = "tf-ami-tmp-instance" })
}