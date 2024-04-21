resource "aws_ssm_parameter" "deploy_tag" {
  name  = "/${local.ssm_prefix_path}/deploy_tag"
  type  = "String"
  insecure_value = "latest"

  tags = var.tags
  lifecycle {
    ignore_changes = [value, insecure_value]
  }
}