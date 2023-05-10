resource "aws_instance" "appserver" {
  ami                    = "ami-082af980f9f5514f8"
  instance_type          = "t2.micro"
  key_name               = "pass"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  tags = {
    Name = "terraform sshable ec2"
  }
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH HTTP inbound traffic"

  ingress {
    description = "HTTP from public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}