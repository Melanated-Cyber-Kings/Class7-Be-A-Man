resource "aws_autoscaling_group" "web_tier" {
  name = "web-asg"
  vpc_zone_identifier = [aws_subnet.private_a.id,aws_subnet.private_b.id, aws_subnet.private_c.id]
  max_size            = 6
  min_size            = 3
  #desired_capacity   = 5
  health_check_type = "ELB"

  target_group_arns = [aws_lb_target_group.web_tier.arn]

  launch_template {
    id = aws_launch_template.web-tier.id
    version = "latest"
  }
  
  tag {
    key = "Name"
    value = "web-instance"
    propagate_at_launch = true
    }

  force_delete = true
}