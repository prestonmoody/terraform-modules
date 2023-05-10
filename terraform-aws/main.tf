resource "aws_instance" "appserver" {
  ami           = "ami-082af980f9f5514f8"
  instance_type = "t2.micro"
  key_name      = "pass"
  tags = {
    Name = "terraform ec2"
  }
}



resource "aws_s3_bucket" "appserver-s3" {
  bucket = "preston-s3-bucket-lesson"

  tags = {
    Name        = "terraform bucket"
    Environment = "lesson"
  }

}
