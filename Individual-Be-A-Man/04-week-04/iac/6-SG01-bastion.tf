# Security group for bastion EC2 instance.

# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

#
# Workstation External IP
#
# This configuration is not required and is
# only provided as an example to easily fetch
# the external IP of your local workstation to
# configure inbound EC2 Security Group access
# to the Kubernetes cluster.
#

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

# Override with variable or hardcoded value if necessary
locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.response_body)}/32"
}

resource "aws_security_group" "bastion-evilbox" {
  name        = "bastion-evilbox"
  description = "security group for bastion EC2 instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow Remote Desktop Protocol Ingress"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    #cidr_blocks = ["${var.client_ip}"]
    cidr_blocks = ["${local.workstation-external-cidr}"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name    = "bastion-evilbox-SG"
    Service = "bastion"
  }

}