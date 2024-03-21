resource "aws_lb" "fargate-alb" {
  name               = var.alb_name
  load_balancer_type = "application"
  internal           = false
  subnets            = module.vpc.public_subnets
  tags = merge(
    local.tags,
    var.alb_tags
  )
  security_groups = [aws_security_group.sg-fargate.id]
}

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.fargate-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = var.alb_default_listener_message
      status_code  = var.alb_default_listener_status_code
    }
  }
}
