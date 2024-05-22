variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "common_tags" {
  type = map(string)
  default = {
    Owner   = "mbocak"
    Project = "Internship_DevOps"
  }
}
