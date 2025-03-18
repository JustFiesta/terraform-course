output "instance_id" {
  description = "ID utworzonej instancji EC2"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Publiczny adres IP instancji"
  value       = aws_instance.this.public_ip
}
