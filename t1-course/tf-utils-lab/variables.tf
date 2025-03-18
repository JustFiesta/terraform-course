variable "ami" {
  description = "ID AMI do użycia"
  type        = string
  validation {
    condition     = can(regex("^ami-[a-zA-Z0-9]+$", var.ami))
    error_message = "AMI ID musi mieć format 'ami-xxxxxx'."
  }
}

variable "instance_type" {
  description = "Typ instancji EC2"
  type        = string
  default     = "t3.micro"
  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Dozwolone wartości: t3.micro, t3.small, t3.medium."
  }
}

variable "subnet_id" {
  description = "ID subnetu"
  type        = string
  validation {
    condition     = can(regex("^subnet-[a-zA-Z0-9]+$", var.subnet_id))
    error_message = "Subnet ID musi mieć format 'subnet-xxxxxx'."
  }
}

variable "instance_name" {
  description = "Nazwa instancji EC2"
  type        = string
  validation {
    condition     = length(var.instance_name) > 3 && length(var.instance_name) < 50
    error_message = "Nazwa instancji powinna mieć od 4 do 50 znaków."
  }
}

variable "enable_monitoring" {
  description = "Czy włączyć monitoring"
  type        = bool
}
