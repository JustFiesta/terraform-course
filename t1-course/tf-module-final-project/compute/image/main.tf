resource "aws_instance" "tmp_golden_instance" {
  ami           = var.base_ami_id
  instance_type = "t3.medium"
  user_data     = var.golden_ami_user_data
  tags = var.instance_tags

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }
}

resource "aws_ami_from_instance" "golden_ami" {
  name               = "${var.project_name}-${var.environment}-golden-ami-${aws_instance.tmp_golden_instance.id}"
  source_instance_id = aws_instance.tmp_golden_instance.id

  depends_on         = [aws_instance.tmp_golden_instance]
}

# remove temporary instance after AMI creation, using local-exec provisioner
resource "null_resource" "delete_tmp_instance" {
  depends_on = [aws_ami_from_instance.golden_ami]

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.tmp_golden_instance.id}"
  }
}