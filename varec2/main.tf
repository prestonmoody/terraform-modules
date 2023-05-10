resource "aws_instance" "tf-ec2" {
  ami           = var.ec2-ami
  instance_type = var.ec2-type
  key_name      = "pass"
  tags = {
    Name = "${var.ec2-name}-server"
    CreatedBy = "preston"
  }
}

output "instance_public_dns" {
  description = "Instance public dns for class main"
  value = aws_instance.tf-ec2.public_dns
}