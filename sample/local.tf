terraform {
  backend "s3" {
    bucket = "tf-state-24"
    key    = "demo"
    region = "ap-southeast-2"
  }
}


provider "aws" {
   region     = "ap-southeast-2"
   
}

resource "aws_instance" "demo" {

    ami = "ami-0375ab65ee943a2a6"  
    instance_type = "t2.micro" 
    tags = {
        Name = "Terraform EC2"
    }
}