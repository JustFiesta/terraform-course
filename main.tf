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
