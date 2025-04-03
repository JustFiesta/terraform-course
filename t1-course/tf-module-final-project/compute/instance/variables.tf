variable "environment" {
  description = "Deploy environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "tf-module-final-project"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t3.micro"
}

variable "instance_tags" {
  description = "Tags to assign to the instance"
  type        = map(string)
}

variable "target_group_arn" {
  description = "Target group ARN for the instance"
  type        = string  
}

variable "subnets" {
  description = "Subnets to launch the instances in"
  type        = list(string)
}

variable "instance_user_data" {
  description = "User data script for the instance"
  type        = string
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