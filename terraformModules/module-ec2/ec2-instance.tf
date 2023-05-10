# Create app server
# Build wep app server on an ec2 and configure
resource "aws_instance" "app_server" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]

  tags = {
      Name = "${var.app_region}-app-server"
  }

  user_data = <<EOF
      #!/bin/bash
      #update os
      yum update -y
      #install apache server
      yum install -y httpd
      # get public ip address of ec2 instance using instance metadata
      TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
      && REGION=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/region` 
      # get date and time of server
      DATE_TIME=`date`
      # set all permissions
      chmod -R 777 /var/www/html
      # create a custom index.html file
      echo "<html>
      <body>
          <h3>This web server is launched from Terraform Modules</h3>
          <p>This instance is created at <b>$DATE_TIME</b></p>
          <p>This instance is running in <b>$REGION</b></p>
      </body>
      </html>" > /var/www/html/index.html
      # start apache server
      systemctl start httpd
      systemctl enable httpd
  EOF
}

# Create security group

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0b08c5e633291978e"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }
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
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_s3_bucket" "moodytfs3" {
  bucket = "moodytfs3"
  
}
