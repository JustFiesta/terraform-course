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
  region = "eu-west-1"
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      Owner       = "terraform"
    }
  }
}

locals {
  tags = {
    Name      = "${var.project_name}-${var.environment}-instance"
    Owner     = "mbocak"
    Project   = "${var.project_name}"
  }
}

module "network" {
  source             = "./network"
  environment        = var.environment
  project_name       = var.project_name
  availability_zones = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
}

module "compute" {
  source           = "./compute"
  environment      = var.environment
  project_name     = var.project_name
  target_group_arn = module.network.target_group_arn
  subnets          = module.network.private_subnet_ids
  instance_tags    = local.tags
  instance_security_group_ids = [ module.network.instance_sg_id ]
  base_ami_id      = "ami-01ff9fc7721895c6b"
  golden_ami_user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    HOSTNAME=$(hostname)
    echo "<html><body><h1>Instance ID: $HOSTNAME</h1></body></html>" > /var/www/html/index.html
    systemctl start httpd
    systemctl enable httpd
  EOF
  )

  key_name = "mbocak-eu-west-1"
}