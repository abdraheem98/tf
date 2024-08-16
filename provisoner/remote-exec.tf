resource "aws_instance" "ec2_example" {

    ami = "ami-03f0544597f43a91d"  
    instance_type = "t2.micro" 
    key_name= "sydpem"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
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
  key_name   = "sydpem"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdbdVUikjHHJxt4KUFmrl2+bv8AaduxgrcsB4pPpGTc8nflB6Uce1FQFGdhe734Ksb42GQKtlReUiyyDLmx4xY4oBQ7TuN9MC0JlLltwayTpS/QyVsZH2ItrCPdFzKU5jRwsnkd06vacGrEeC4iaNke3yHK5gG5oB0eMcNsXC3UwbLPcDXTIeaHYKydS3BA9OycDbSkFCdrE+SZ+tbkdsq/k7KXe6/pAsj9Za5yLz29tnK8EHxzoyd+SBvgsf7JpTxRyeiif0OKgaeAUluQEMRlEft4LaW5tbXOAHXoGrZSi4fAfff7WD2EZ22RRH+5ZIRo6vF8096n2QBy5lNhg37HinjnqzR84O349Pw0zOASxjChspToRa1Tiekq+YoHtQ1P+Q8IU3tdUjtt03CbacoaAbhPrxcAvV8eY/FCcQTytHTo627d/U8wvKvYfgTM67CLlhAUJYEyuD66L765USOspPzfV0GOT9IJm98PhWmdesI4XVdfW7jDFWOLP4oc+0= root@ip-172-31-9-223"
}