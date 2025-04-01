output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "value of the target group ARN"
  value       = aws_lb_target_group.main.arn
}

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

output "security_group_ids" {
  description = "The IDs of the security groups"
  value       = aws_security_group.main.id
}