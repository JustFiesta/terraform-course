terraform {
  backend "s3" {
    bucket = "tf-assesment-156231"
    key    = "terraform/state"
    region = "eu-west-1"
  }
}
