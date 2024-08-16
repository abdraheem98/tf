resource "aws_instance" "example" {
  ami           = "ami-03f0544597f43a91d"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo 'Instance ${self.id} created!'"
  }
}
