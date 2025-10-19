resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app1.id

  tags = {
    Name    = "app1_IG"
    Service = "application1"
    Be-A-Man   = "Week4"
    Challenge-Number  = "4.1"
  }
}
