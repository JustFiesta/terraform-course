variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sec_group_id" {
  type = string
}

variable "user_data" {
  type     = string
  default = <<EOF
	#!/usr/bin/env bash
	sudo yum update
	sudo yum install httpd
	sudo systemctl enable httpd
	sudo systemctl start httpd
    echo "<html><h1>Hello, World!</h1></html>" > /var/www/html/index.html
	EOF
}

variable "common_tags" {
    type = map(string)
}