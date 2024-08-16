terraform {
  backend "s3" {
    bucket         = "mytesttfbucket2024"   
    key            = "terraform.tfstate"     
    region         = "ap-southeast-2"                    
    encrypt        = true                          
    dynamodb_table = "terraform-lock-table"         
  }
}

provider "aws" {
  region = "ap-southeast-2"  
}

resource "aws_instance" "example" {
  ami           = "ami-03f0544597f43a91d"   
  instance_type = "t2.micro"
  tags = {
    Name = "example-instance"
  }
}

output "instance_id" {
  value = aws_instance.example.id
}
