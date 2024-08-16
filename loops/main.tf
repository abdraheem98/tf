variable "instance_types" {
  description = "List of instance types"
  type        = list(string)
  default     = ["t2.micro", "t2.small"]
}

resource "aws_instance" "example" {
  count         = length(var.instance_types)
  ami           = "ami-03f0544597f43a91d"
  instance_type = var.instance_types[count.index]

  tags = {
    Name = "Instance ${count.index}"
  }
}
