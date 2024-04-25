resource "aws_lb_target_group" "main" {
  name = local.name_prefix

  # Target
  vpc_id               = var.vpc_id
  target_type          = "instance"
  protocol             = "HTTP"
  port                 = var.container_port
  deregistration_delay = 30
  slow_start           = 0

  # Tags
  tags = var.tags

  stickiness {
    enabled         = false
    cookie_duration = 86400
    type            = "lb_cookie"
  }

  health_check {
    enabled  = true
    interval = 15

    matcher  = "200-299"
    protocol = "HTTP"
    port     = "traffic-port"
    path     = var.health_check_path

    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}
