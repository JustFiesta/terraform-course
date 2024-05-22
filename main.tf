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

module "network" {
  source = "./modules/network"

  common_tags  = var.common_tags
}

module "compute" {
  source = "./modules/compute"

  subnet_id    = module.network.subnet_id
  sec_group_id = module.network.sec_group_id

  common_tags  = var.common_tags
}
