# Variables for VPC deployment

variable "region" {
  default = "eu-central-1"
}

# core VPC paramters 
variable "vpc_cidr" {
  default = "10.214.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for all subnets by name"
  type = object({
    public_zone1  = string
    public_zone2  = string
    public_zone3  = string
    private_zone1 = string
    private_zone2 = string
    private_zone3 = string

  })

  # Setup subnets in 3 separate availability zones in the AWS region.

  default = {
    public_zone1  = "10.214.1.0/24"
    public_zone2  = "10.214.2.0/24"
    public_zone3  = "10.214.3.0/24"
    private_zone1 = "10.214.11.0/24"
    private_zone2 = "10.214.12.0/24"
    private_zone3 = "10.214.13.0/24"
  }
}

locals {
  zone1 = "${var.region}a"
  zone2 = "${var.region}b"
  zone3 = "${var.region}c"
}

variable "vpc_name" {
  default     = "demo"
  type        = string
  description = "AWS Academic VPC"
  nullable    = false
}

# Set remote client IP address for security group rules.

variable "client_ip" {
  type    = string
  default = "0.0.0.0/0"
  # client_ip_addr =  # insert IP address and CIDR in this field.
}