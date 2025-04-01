output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.load_balancer.lb_dns_name
}

output "target_group_arn" {
  description = "value of the target group ARN"
  value       = module.load_balancer.target_group_arn
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.vpc.private_subnet_ids
}

output "instance_security_group_id" {
  description = "The ID of instance security group"
  value       = module.vpc.instance_security_group_id
}