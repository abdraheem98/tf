terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "demo" {
  ami = var.ami
  instance_type = var.instance_type
  availability_zone = var.availability_zone

  tags = {
    Name = "demo-ec2"
  }
}