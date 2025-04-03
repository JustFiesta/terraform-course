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

variable "target_group_arn" {
  description = "Target group ARN for the instance"
  type        = string  
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "instance_tags" {
  description = "Tags for the instance"
  type        = map(string)
}

variable "instance_security_group_ids" {
  description = "Security group ID for the instance"
  type        = list(string)
}


variable "key_name" {
  description = "Key pair name for dev SSH access"
  type        = string
  default     = ""
}