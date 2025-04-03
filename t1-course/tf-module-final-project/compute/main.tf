module "image" {
  source        = "./image"
  environment   = var.environment
  project_name  = var.project_name
  instance_tags = var.instance_tags
  base_ami_id   = "ami-0df368112825f8d8f"
}

module "instance" {
  source       = "./instance"
  environment  = var.environment
  project_name = var.project_name
  ami_id       = module.image.ami_id
  target_group_arn = var.target_group_arn
  public_subnets = var.public_subnets
  instance_tags = var.instance_tags
}
