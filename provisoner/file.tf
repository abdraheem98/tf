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

resource "aws_instance" "ec2_example" {

    ami = "ami-0375ab65ee943a2a6"  
    instance_type = "t2.micro" 
    key_name= "awskey"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "file" {
    source      = "/home/ubuntu/index.html"
    destination = "/home/ubuntu/index.html"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/id_rsa")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "awskey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz2h0qtTfLJNG25KEGAnri8uxZ6BPLyVNBs0SKtMWSovtco1zCfCuSAtJCIr477L2MQXdWvlsRkm7gBk4XtyVbN5jr1wbu9vEXI/vftxD5+b0LP4nN0DzIW7gSJQ8rI5Ay7w7Zs2kRH27DS0Agsq5VVf9BNamMFU4/YvuOXILrWInPb6/Lh/1dxGkkXfS/7+/tQ0eLoth+tFke++1T5N95ZQ6pcZxpMvervRojjk4Urq6X5idQu/bgdbCKPU/MGobgqpwV5ko4FLjhLjI3360e+B6Llgm1x+auu79XsmzTEb27XiEyTFjIi5iDP/npeHjvTFLWg8/UVRPR5x2Bp5aAyC3v12o4YQ/km1UmE0oXiwI/IXtBXwiqhieWtD6R0ov6uLz3I/I45j80RjR5R9vrSM71vTgviPE2vZdrlZr3u+CZ4EeWyeXOhyp/saSfs2q5wYTVNJW1qmGopagiGLDYxiS7RzJ/QHxQpwLEcrUaKLsR3/AFLMhGB3pL8LbZTME= ubuntu@ip-172-31-12-134"
}