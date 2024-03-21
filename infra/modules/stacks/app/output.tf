output "aws_ecr_repository_url" {
  value = aws_ecr_repository.ecr-app.repository_url
}

output "health_check_url" {
  value = "http://${data.aws_lb.selected.dns_name}${aws_lb_target_group.tg-app.health_check[0].path}"
}
