provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-03f0544597f43a91d"
  instance_type = var.instance_type
}
