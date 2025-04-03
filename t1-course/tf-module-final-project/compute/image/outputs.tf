output "golden_ami_id" {
  description = "The AMI ID of the golden image created."
  value       = aws_ami_from_instance.golden_ami.id
}