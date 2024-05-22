terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
 
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

# Create temporary instance with httpd running
resource "aws_instance" "tf-tmp-instance" {
  ami           = "ami-005e54dee72cc1d00"
  instance_type = "t3.micro"

  user_data = var.user_data

  tags = merge(var.common_tags, { Name = "tf-tmp-instance" })
}

# Create image from tmp instance
resource "aws_ami_from_instance" "tf-ami-tmp-instance" {
  name               = "tf-ami-tmp-instance"
  source_instance_id = aws_instance.tf-tmp-instance.id
  depends_on         = [aws_instance.tf-tmp-instance]

  tags = merge(var.common_tags, { Name = "tf-ami-tmp-instance" })
}

# Remove instance after image was created
resource "aws_instance" "tf-tmp-instance" {
  lifecycle {
    create_before_destroy = true
  }
}