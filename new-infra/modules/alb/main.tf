resource "aws_lb" "main" {
  name                       = local.name_prefix
  internal                   = false
  enable_deletion_protection = false
  enable_http2               = true
  load_balancer_type         = "application"
  idle_timeout               = 60
  enable_waf_fail_open       = true

  # Network
  security_groups = [aws_security_group.main.id]
  subnets         = var.public_subnets
  ip_address_type = "ipv4"

  # Tags
  tags = var.tags

  # Access logs
  #   access_logs {
  #     enabled = true
  #     bucket  = "tbd"
  #     prefix  = "s3 prefix tbd"
  #   }
}