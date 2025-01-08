output "ami_id" {
  description = "AMI id from temporary instance"
  value = aws_ami_from_instance.tf_ami_tmp_instance.id
}