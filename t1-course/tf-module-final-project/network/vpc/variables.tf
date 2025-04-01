variable "vpc_cidr" {
  type = string
  description = "CIDR block for the main VPC"
  default = "10.0.0.0/24"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  type = string
  description = "Environment for the resources"
}
