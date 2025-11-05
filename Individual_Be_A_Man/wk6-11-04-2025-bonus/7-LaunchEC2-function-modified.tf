
#grab the latest ami id from AWS
data "aws_ami" "latest_t3_micro" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # example for Amazon Linux 2 AMI
  }

  owners = ["amazon"]  # owner alias for official Amazon images
}






resource "aws_launch_template" "app1_LT" {
  name_prefix   = "app1_LT"
  #image_id      = "ami-0807bd3aff0ae7273"  
  #instance_type = "t3.micro"

  #no longer hard coded ami 
  image_id           = data.aws_ami.latest_t3_micro.id
  instance_type = "t3.micro"
  
  


  key_name = "Class7tmpKey"

  vpc_security_group_ids = [aws_security_group.app1-sg01-servers.id]

  user_data = base64encode(file("user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "app1_LT"
      Service = "application1"
      Owner   = "Chewbacca"
      Planet  = "Mustafar"
    }
  }

  #makes sure the new one is up before tossing the old one
  
  #uncomment if you're doing auto scaling groups.  otherwise you'll have 
  #log into the console and terminate them directly first.  
  #terraform destroy won't finish
  #lifecycle {
  #  create_before_destroy = true
  #}
}


#actually launch an instance, specifiying which subnet to use
resource "aws_instance" "example" {
  launch_template {
    id      = aws_launch_template.app1_LT.id
    version = "$Latest"
  }
  subnet_id = aws_subnet.public-us-east-2a.id
  
  
  tags = {
    CreatedAt = timestamp()
  }
 
  
}

#give me the ip address
output "public_ip" {
  value = aws_instance.example.public_ip
}

#give the public dns of this instance
output "public_dns" {
  description = "Public DNS name of the EC2 instance."
  value       = aws_instance.example.public_dns
}

output "CreatedTime" {
  value = aws_instance.example.tags.CreatedAt
}
  
