# Deploy Network Address Translation

resource "aws_eip" "nat" {

  tags = {
    Name = "nat"
  }
}

# Assign NAT gateway in *1* availibility zone. 

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_zone1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}