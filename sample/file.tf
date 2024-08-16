provider "aws" {
   region     = "ap-southeast-2"
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0375ab65ee943a2a6"  
    instance_type = "t2.micro" 
    key_name= "remotekey"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "file" {
    source      = "/home/ubuntu/demo.txt"
    destination = "/home/ubuntu/demo.txt"
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

resource "aws_key_pair" "sample" {
  key_name   = "remotekey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChsESdEdQh8dqvv3SYPSMkwUW3Xb60OvYVGzv6GJUXRFxbQ/OpAwjrLkHyGeUh1jNomPeHAga8oV73QPbA1Lp8WYexqDW4+FWQKyQexkZJ75Aas616vApIqMutqzN7O1wgS2S9wvC7xVvvCucyO7rlMjqLAKhOMXUp3VXxlsOHtqf7e5BylqnKrNPfsmvCRtPMJm9AcLs/CVHQiSV34SxEIHxtrkyP1WhV7FtMab50GlXiXiCWFYtplX/NbI60xNWqO7iLwJPNUVljb5W7rQdZTmQI0imJgLTdhzfYMePO4WsfPXO9Nqh8vlx42d/kSppToFo1eYZJAH4JbXJ9cII3 ubuntu@ip-172-31-4-199"
} 