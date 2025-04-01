variable "vpc_cidr" {
  type = string
  description = "CIDR block for the main VPC"
  default = "10.0.0.0/16"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  type = string
  description = "Environment for the resources"
}

variable "number_of_subnets" {
  description = "Number of subnets of each type to create (cannot be less than 2, due to LB requirements)"
  type        = number
  default     = 2
}
