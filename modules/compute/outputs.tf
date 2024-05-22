output "ami_id" {
  value = aws_ami_from_instance.tf-ami-tmp-instance.id
}