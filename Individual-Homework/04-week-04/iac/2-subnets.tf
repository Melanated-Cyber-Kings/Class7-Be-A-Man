# Setup subnets for VPC

# Setup public subnets. 1 subnet per availability zone.

resource "aws_subnet" "public_zone1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_blocks.public_zone1
  availability_zone       = local.zone1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${local.zone1}"
  }
}

resource "aws_subnet" "public_zone2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_blocks.public_zone2
  availability_zone       = local.zone2
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${local.zone2}"
  }
}

resource "aws_subnet" "public_zone3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_blocks.public_zone3
  availability_zone       = local.zone3
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${local.zone3}"
  }
}


# Private subnets. 1 Subnet for each availability zone.

resource "aws_subnet" "private_zone1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks.private_zone1
  availability_zone = local.zone1

  tags = {
    Name = "private-${local.zone1}"
  }
}

resource "aws_subnet" "private_zone2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks.private_zone2
  availability_zone = local.zone2

  tags = {
    Name = "private-${local.zone2}"
  }
}

resource "aws_subnet" "private_zone3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks.private_zone3
  availability_zone = local.zone3

  tags = {
    Name = "private-${local.zone3}"
  }
}