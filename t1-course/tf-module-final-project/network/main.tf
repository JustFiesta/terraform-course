module "vpc" {
  source       = "./vpc"
  environment  = var.environment
  project_name = var.project_name
  
  subnet_count = 1
}

module "load_balancer" {
  source             = "./load_balancer"
  environment        = var.environment
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_group_ids = [module.vpc.security_group_id]
}