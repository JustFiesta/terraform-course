module "image" {
  source        = "./image"
  environment   = var.environment
  project_name  = var.project_name
  instance_tags = var.instance_tags
  base_ami_id   = "ami-0df368112825f8d8f"
}

module "instance" {
  source           = "./instance"
  environment      = var.environment
  project_name     = var.project_name
  ami_id           = module.image.golden_ami_id
  target_group_arn = var.target_group_arn
  subnets          = var.subnets
  instance_tags    = var.instance_tags
  instance_security_group_ids = var.instance_security_group_ids
  key_name         = var.key_name
}
