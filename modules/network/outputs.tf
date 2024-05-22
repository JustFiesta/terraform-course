output "vpc_id" {
  value = aws_vpc.tf-vpc.id
}

output "subnet_id" {
  value = aws_subnet.tf-subnet.id
}

output "sec_group_id" {
  value = aws_security_group.tf-sec-group.id
}

output "eip_ec2_id" {
  value = aws_eip.tf-public-ip.id
}
