resource "aws_security_group" "web-lb" {
  name        = "web-alb-sg"
  description = "Allow inbound traffic and all outbound traffic to terraform vpc"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web-lb-http_ipv4" {
  description = "HTTP from anywhere"
  security_group_id = aws_security_group.web-lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

## tags to name the security group rule
   tags = {
     Name = "HTTP"
   }
}

resource "aws_vpc_security_group_egress_rule" "terraform-sg_traffic_ipv4" {
  security_group_id = aws_security_group.web-lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }