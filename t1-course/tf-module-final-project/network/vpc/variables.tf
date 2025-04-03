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

variable "availability_zones" {
  description = "List of availability zones to use for the subnets"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}