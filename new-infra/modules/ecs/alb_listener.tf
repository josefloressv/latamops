resource "aws_lb_listener_rule" "main" {
  listener_arn = var.alb_http_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
  condition {
    path_pattern {
      values = ["/"]
    }
  }
  tags = var.tags
}