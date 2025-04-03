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

variable "instance_tags" {
  description = "Tags for the instance"
  type        = map(string)
}

variable "golden_ami_user_data" {
  description = "User data for the golden AMI instance"
  type        = string
}

variable "base_ami_id" {
  description = "Base AMI ID to use for the golden image"
  type        = string
}