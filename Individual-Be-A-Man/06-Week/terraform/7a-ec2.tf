resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0bdd88bd06d16ba03" # us-west-2
  instance_type = "t3.micro"

  security_groups = [aws_security_group.web-server.id]
  subnet_id = aws_subnet.public_a.id
  associate_public_ip_address = true
  #public_dns = true
  

  user_data = file("user_data.sh")

   tags = {
     Name = "terraform-ec2"
   }
  
}