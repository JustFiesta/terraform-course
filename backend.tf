terraform {
  backend "s3" {
    bucket = var.s3-bucket
    key    = "terraform/state"
    region = var.region

    tags = merge(var.common_tags, { Name = "tf-s3" })
  }
}
