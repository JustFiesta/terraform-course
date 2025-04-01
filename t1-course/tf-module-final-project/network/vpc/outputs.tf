output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the subnets"
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the subnets"
  value = aws_subnet.private[*].id
}

output "lb_security_group_id" {
  description = "The ID of the LB security group"
  value       = aws_security_group.lb.id
}

output "instance_security_group_id" {
  description = "The ID of the instance security group"
  value       = aws_security_group.instance.id
}