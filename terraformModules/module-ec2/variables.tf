variable "ami" {
  type = string
  description = "ami-082af980f9f5514f8"
}

variable "app_region" {
  type = string
  default = "eu-west-1"

}

variable "instance_type" {
  type = string
  default = "t2.micro"
}