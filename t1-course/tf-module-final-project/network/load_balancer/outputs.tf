output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "value of the target group ARN"
  value       = aws_lb_target_group.main.arn
}