output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = [aws_subnet.tf_a.id, aws_subnet.tf_b.id]
}

output "sec_group_id" {
  value = aws_security_group.tf_ssh_http.id
}

output "eip_ec2_id" {
  value = aws_eip.tf_public.id
}
