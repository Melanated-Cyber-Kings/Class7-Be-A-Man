# Reference your existing AWS key pair
data "aws_key_pair" "MyWindows" {
  key_name = "MyWindows"
}
/*
resource "tls_private_key" "MyWindows" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "tls_public_key" "MyWindows" {
  private_key_pem = tls_private_key.MyWindows.private_key_pem
}

output "private_key" {
  value     = tls_private_key.MyWindows.private_key_pem
  sensitive = true
}

output "public_key" {
  value = data.tls_public_key.MyWindows.public_key_openssh
}
*/