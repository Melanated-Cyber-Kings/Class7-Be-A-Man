data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "image-id"
    values = ["ami-0bc691261a82b32bc"]
  }
}