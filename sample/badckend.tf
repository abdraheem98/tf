
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}

# Configure the AWS provider
provider "aws" {
  region = "ap-southeast-2 "
}

# Create an EC2 key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")  
}

# Create a security group allowing SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Provision an EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-0375ab65ee943a2a6"  
  instance_type = "t2.micro"

  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "Terraform-Example"
  }
}


output "instance_public_ip" {
  description = "The public IP address of the web server instance"
  value       = aws_instance.web.public_ip
}
