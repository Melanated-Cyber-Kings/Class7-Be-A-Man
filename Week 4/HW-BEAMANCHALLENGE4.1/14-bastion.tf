# Bastion Host (in public subnet eu-west-1a)
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-eu-west-1a.id  # Your existing public subnet
  vpc_security_group_ids = [aws_security_group.app1-sg01-servers.id]  # Use your existing SG
  key_name               = data.aws_key_pair.MyWindows.key_name
  
  tags = {
    Name    = "bastion-host"
    Service = "application1"
    Be-A-Man = "Week4"
    Challenge-Number = "4.1"
  }
}

# Security Group for Bastion
resource "aws_security_group" "bastion" {
  name_prefix = "bastion-sg-"
  vpc_id      = aws_vpc.app1.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this to your IP in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}