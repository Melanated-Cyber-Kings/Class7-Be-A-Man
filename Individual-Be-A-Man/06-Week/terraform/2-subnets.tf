############# Public Subnets ##########################

resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.main.id
  cidr_block       = "10.10.1.0/24"
  availability_zone = "us-east-1a" # Specify AZ
  map_public_ip_on_launch = true   # Allow public IPs to be assigned

  tags = {
    Name = "public-subnet-us-east-1a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.main.id
  cidr_block       = "10.10.2.0/24"
  availability_zone = "us-east-1b" # Specify AZ
  map_public_ip_on_launch = true   # Allow public IPs to be assigned

  tags = {
    Name = "public-subnet-us-east-1b"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id = aws_vpc.main.id
  cidr_block       = "10.10.3.0/24" 
  availability_zone = "us-east-1c"  # Specify AZ
  map_public_ip_on_launch = true    # Allow public IPs to be assigned

  tags = {
    Name = "public-subnet-us-east-1c"
  }
}

############# Private Subnets ##########################

resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.main.id
  cidr_block       = "10.10.11.0/24"
  availability_zone = "us-east-1a"  # Specify AZ
  map_public_ip_on_launch = false   # Optional default value is false, Allow public IPs to be assigned

  tags = {
    Name = "private-subnet-us-east-1a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id = aws_vpc.main.id
  cidr_block       = "10.10.12.0/24"
  availability_zone = "us-east-1b"  # Specify AZ
  map_public_ip_on_launch = false   # Optional default value is false, Allow public IPs to be assigned

  tags = {
    Name = "private-subnet-us-east-1b"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id = aws_vpc.main.id
  cidr_block       = "10.10.13.0/24" 
  availability_zone = "us-east-1c"  # Specify AZ
  map_public_ip_on_launch = false   # Optional default value is false, Allow public IPs to be assigned

  tags = {
    Name = "private-subnet-us-east-1c"
  }
}
