output "alb_http_listener_arn" {
  value = aws_lb_listener.http.arn
}

output "alb_dns" {
  value = aws_lb.main.dns_name
}