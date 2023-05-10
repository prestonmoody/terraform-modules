module "ec2Instance-us" {
  source = "../module-ec2"
  ami = "ami-082af980f9f5514f8"
  app_region = "eu-west-1"
  instance_type = "t2.micro"  
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}