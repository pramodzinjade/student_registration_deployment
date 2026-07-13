variable "ami" {
  default = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key" {
  default = "ubuntunewkey"
}

variable "vpc-cidr_block" {
  default = "10.0.0.0/16"
}
 
 variable "availibility-zone" {
   default = "us-east-1a"
 }
 variable "subnet-cidr_block" {
   default = "10.0.0.0/20"
 }
 variable "IGW-cidr" {
   default = "0.0.0.0/0"
 }