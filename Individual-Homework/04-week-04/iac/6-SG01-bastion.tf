# Security group for bastion EC2 instance.

resource "aws_security_group" "bastion-evilbox" {
  name        = "bastion-evilbox"
  description = "security group for bastion EC2 instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow Remote Desktop Protocol Ingress"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "bastion-evilbox-SG"
    Service = "bastion"
  }

}