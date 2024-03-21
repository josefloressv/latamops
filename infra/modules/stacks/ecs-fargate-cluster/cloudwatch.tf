resource "aws_kms_key" "cluster" {
  description = "KMS key for ECS cluster ${var.cluster_name}"

  # Note: After the waiting period ends, AWS KMS deletes the KMS key.
  # If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30
  deletion_window_in_days = 7
  tags                    = local.tags
}

resource "aws_cloudwatch_log_group" "cluster" {
  name              = "/aws/ecs/${var.cluster_name}"
  retention_in_days = var.cloudwatch_retention_in_days
  tags              = local.tags
}
