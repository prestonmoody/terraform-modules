  provider "aws" {
  region = "eu-west-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }


  backend "s3" {
    bucket         = "tf-s3-state-moodytf"
    key            = "tfstates/codeplatoon/s3demo.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tf_dynmodb_state_lock"
    encrypt        = true
  }

}