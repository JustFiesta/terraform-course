output "golden_ami_id" {
  description = "The AMI ID of the golden image created."
  value       = aws_ami.golden_ami.id
}