output "lb_sg_id" {
  description = "ID of the Load Balancer security group"
  value       = aws_security_group.lb.id
}

output "instance_sg_id" {
  description = "ID of the instance security group"
  value       = aws_security_group.instance.id
}