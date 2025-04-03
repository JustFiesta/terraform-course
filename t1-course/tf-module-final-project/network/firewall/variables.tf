variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  type = string
  description = "Environment for the resources"
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}
