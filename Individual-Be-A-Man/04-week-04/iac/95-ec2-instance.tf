# AWS EC2 Instance Deployment
# Quantity: 3
# Assignment: 1 EC2 instance in each availability zone.

# Each instance will run a different web page to provide distinction.

resource "aws_instance" "web-svr-01" {
  ami                    = "ami-08697da0e8d9f59ec"
  instance_type          = "t2.micro"
  availability_zone      = local.zone1
  key_name               = "eu-west-web-key"
  subnet_id              = aws_subnet.private_zone1.id
  vpc_security_group_ids = [aws_security_group.web-server.id]

  user_data = file("user-data-websvr01.tpl")


  depends_on = [aws_vpc.main, aws_subnet.private_zone1, aws_security_group.web-server]

  tags = {
    Name = "web-svr-01"
  }

}

resource "aws_instance" "web-svr-02" {
  ami                    = "ami-08697da0e8d9f59ec"
  instance_type          = "t2.micro"
  availability_zone      = local.zone2
  key_name               = "eu-west-web-key"
  subnet_id              = aws_subnet.private_zone2.id
  vpc_security_group_ids = [aws_security_group.web-server.id]

  user_data = file("user-data-websvr02.tpl")


  depends_on = [aws_vpc.main, aws_subnet.private_zone1, aws_security_group.web-server]

  tags = {
    Name = "web-svr-02"
  }

}

resource "aws_instance" "web-svr-03" {
  ami                    = "ami-08697da0e8d9f59ec"
  instance_type          = "t2.micro"
  availability_zone      = local.zone3
  key_name               = "eu-west-web-key"
  subnet_id              = aws_subnet.private_zone3.id
  vpc_security_group_ids = [aws_security_group.web-server.id]

  user_data = file("user-data-websvr03.tpl")


  depends_on = [aws_vpc.main, aws_subnet.private_zone1, aws_security_group.web-server]

  tags = {
    Name = "web-svr-03"
  }

}


