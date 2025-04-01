variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  type = string
  description = "Environment for the resources"
}

variable "vpc_id" {
  description = "VPC ID where the load balancer will be created"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the load balancer"
  type        = list(string)
}