variable "ami" {
  type = string
  default = "ami-03f0544597f43a91d"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "availability_zone" {
  type = string
  default = "ap-southeast-2a"
}