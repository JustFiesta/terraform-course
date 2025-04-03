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
  default     = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get upgrade -y
              sudo apt-get install -y apache2
              sudo systemctl enable apache2
              sudo systemctl start apache2

              echo "<h1>Server: $(hostname)</h1>" > /var/www/html/index.html
              systemctl restart apache2
              EOF
}

variable "base_ami_id" {
  description = "Base AMI ID to use for the golden image"
  type        = string
}