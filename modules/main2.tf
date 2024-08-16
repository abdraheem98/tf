module "my_ec2_instance" {
  source        = "./modules"     
  ami_id        = "ami-03f0544597f43a91d"    
  instance_type = "t2.small"        
  region        = "ap-southeast-2"       
}

output "ec2_instance_id" {
  value = module.my_ec2_instance.instance_id
}

