module "vpc" {
  source       = "./vpc"
  environment  = var.environment
  project_name = var.project_name

  availability_zones = var.availability_zones
}

module "load_balancer" {
  source             = "./load_balancer"
  environment        = var.environment
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnet_ids
  security_group_ids = [module.vpc.lb_security_group_id]

  depends_on = [module.vpc]
}

module "firewall" {
  source = "./firewall"
  environment = var.environment
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id

  depends_on = [ module.vpc ]
}