variable "environment" {
  description = "Deploy environment"
  type        = string
  default = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "tf-module-final-project"
}

variable "security_group_ids" {
  description = "List of security group IDs for the load balancer"
  type        = list(string)
}