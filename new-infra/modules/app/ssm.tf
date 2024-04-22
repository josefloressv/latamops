resource "aws_ssm_parameter" "deploy_tag" {
  name  = "/${local.ssm_prefix_path}/deploy_tag"
  type  = "String"
  insecure_value = "latest"

  tags = var.tags
  lifecycle {
    ignore_changes = [value, insecure_value]
  }
}

resource "aws_ssm_parameter" "mysql_jdb_url" {
  name  = "/${local.ssm_prefix_path}/mysql_jdb_url"
  type  = "SecureString"
  value = "jdbc:mysql://dbclusterendpoint/dbname"

  tags = var.tags
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "mysql_username" {
  name  = "/${local.ssm_prefix_path}/mysql_username"
  type  = "SecureString"
  value = "dummy"

  tags = var.tags
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "mysql_password" {
  name  = "/${local.ssm_prefix_path}/mysql_password"
  type  = "SecureString"
  value = "dummy"

  tags = var.tags
  lifecycle {
    ignore_changes = [value]
  }
}
