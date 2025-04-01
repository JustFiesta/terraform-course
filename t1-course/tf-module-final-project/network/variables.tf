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

variable "availability_zones" {
  description = "List of availability zones to use for the subnets"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}