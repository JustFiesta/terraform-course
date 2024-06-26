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
  region    = var.region
  default_tags {
    tags = {
      Name        = "tf_assesment"
      Owner       = "mbocak"
      Project     = "Internship_DevOps"
    }
  }
}

module "network" {
  source = "./modules/network"
}

module "compute" {
  source = "./modules/compute"

  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.subnet_ids
  sec_group_id = module.network.sec_group_id

  depends_on   = [module.network]
}
