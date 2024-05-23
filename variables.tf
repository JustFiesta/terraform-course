variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "s3-bucket" {
  type    = string
  default = "bucket-link"
}

variable "common_tags" {
  type = map(string)
  default = {
    Owner   = "mbocak"
    Project = "Internship_DevOps"
  }
}

# Acces IP range for load balancer
variable "allowed_ip_range" {
  description = "The IP range allowed to access the load balancer"
  default     = "0.0.0.0/0"
}
