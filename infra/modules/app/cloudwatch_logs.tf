resource "aws_cloudwatch_log_group" "main" {
  name              = local.name_prefix
  retention_in_days = 3
  tags              = var.tags
}