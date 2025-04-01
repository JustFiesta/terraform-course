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

module "firewall" {
  source       = "./firewall"
  environment  = var.environment
  project_name = var.project_name
}

module "network" {
  source       = "./network"
  environment  = var.environment
  project_name = var.project_name
  security_group_ids = module.firewall.main.id
}