variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "tf_a_sub" {
    type  = string
    default = "172.16.10.0/24"
}

variable "tf_b_sub" {
    type  = string
    default = "172.16.10.0/24"
}

variable "lb_port" {
    type  = number
    default = 80
}