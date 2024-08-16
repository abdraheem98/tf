variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

resource "aws_db_instance" "example" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  db_name           = "exampledb"
  username          = "admin"
  password          = var.db_password
}
