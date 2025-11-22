resource "aws_security_group" "web-server" {
  name        = "web-server"
  description = "Allow inbound traffic and all outbound traffic to terraform vpc"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web-server-sg"
    Tier = "Web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web-server-ssh_ipv4" {
  description = "SSH from anywhere"
  security_group_id = aws_security_group.web-server.id
  cidr_ipv4         = "10.10.0.0/16"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

## tags to name the security group rule
   tags = {
     Name = "SSH"
   }
}

resource "aws_vpc_security_group_ingress_rule" "web-server-http_ipv4" {
  description = "HTTP from ALB"
  security_group_id = aws_security_group.web-server.id
  
  referenced_security_group_id = aws_security_group.web-lb.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

## tags to name the security group rule
   tags = {
     Name = "HTTP"
   }
}

resource "aws_vpc_security_group_egress_rule" "web-server_traffic_ipv4" {
  security_group_id = aws_security_group.web-server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }