resource "aws_vpc" "main" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default" # Optional default option is setting this to default
  enable_dns_hostnames = true
  enable_dns_support = true # Optional default is true


  tags = {
    Name = "terraform-vpc"
  }
}