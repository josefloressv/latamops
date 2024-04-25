resource "aws_ecr_repository" "main" {
  name                 = "${local.name_prefix}${var.name_sufix}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  tags         = var.tags
}