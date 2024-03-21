resource "aws_lb_target_group" "tg-app" {
  name        = var.tg_name
  target_type = "ip"
  vpc_id      = var.aws_vpc_id
  port        = var.tg_port
  protocol    = "HTTP"
  health_check {
    path                = var.tg_health_check_path
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }

  tags = merge(
    local.tags,
    var.tg_tags
  )
}

data "aws_lb" "selected" {
  name = var.tg_alb_name
}

data "aws_lb_listener" "selected80" {
  load_balancer_arn = data.aws_lb.selected.arn
  port              = var.tg_port
}

resource "aws_lb_listener_rule" "lr-rule" {
  listener_arn = data.aws_lb_listener.selected80.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-app.arn
  }

  condition {
    path_pattern {
      values = [var.listener_context_path]
    }
  }
}
