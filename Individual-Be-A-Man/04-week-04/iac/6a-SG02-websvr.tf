# Security group for Linux EC2 instance.

resource "aws_security_group" "web-server" {
  name        = "sg02-web-server"
  description = "security group for Linux EC2 instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow Secure Shell Protocol Ingress from Public Zone 1"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion-evilbox.id}"]

  }

  ingress {
    description     = "Allow HTTP Ingress from Public Zone 1"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion-evilbox.id}"]

  }
  # ICMP for troubleshooting *ONLY*
  ingress {
    description     = "Allow ICMP Ingress from Public Zone 1"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = ["${aws_security_group.bastion-evilbox.id}"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "web-server-sg"
    Service = "web service"
  }

}