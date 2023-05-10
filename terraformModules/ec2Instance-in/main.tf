module "ec2Instance-in" {
  source = "../module-ec2"
  ami = "ami-01a4f99c4ac11b03c"
  app_region = "ap-south-1"
  instance_type = "t2.micro"
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}