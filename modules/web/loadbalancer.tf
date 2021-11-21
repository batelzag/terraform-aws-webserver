# Create Application Load Balancer #
resource "aws_lb" "web-alb" {
  name                       = "web-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.public_subnets
  security_groups            = [aws_security_group.web-instances-sg.id]

  tags = {
    "Name" = "web-alb"
  }
}
# Creates a listner for ALB using http 
resource "aws_lb_listener" "web-alb" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-alb.arn
  }
}
# Creates a Target Group resource for use with ALB resources
resource "aws_lb_target_group" "web-alb" {
  name     = "web-instances-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    path    = "/"
  }
  stickiness {
    type = "lb_cookie"
    cookie_duration = 60
  }
  
  tags = {
    "Name" = "web-instances-target-group"
  }
}
resource "aws_lb_target_group_attachment" "web_server" {
  count            = length(aws_instance.web)
  target_group_arn = aws_lb_target_group.web-alb.id
  target_id        = aws_instance.web.*.id[count.index]
  port             = 80
}
