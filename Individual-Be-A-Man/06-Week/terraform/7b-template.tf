resource "aws_launch_template" "web-tier" {
  description = "Launch template for web tier servers"

  image_id = "ami-0bdd88bd06d16ba03"
  instance_type = "t3-micro"
  user_data = filebase64("../../01-Week/BAM/BAM 1.1/ec2_script_1.sh")
  vpc_security_group_ids = [ aws_security_group.web-server.id ]
  
  
  tags = {
    Name ="web-tier-server-template"

  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Managedby = "Terraform" 
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}