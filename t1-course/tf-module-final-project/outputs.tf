output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.network.lb_dns_name
  depends_on  = [module.network]
}
