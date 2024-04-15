locals {
  name_prefix = "${var.application}-${var.environment}"
  common_tags = {
    Application    = var.application
    Environment    = var.environment
    Provisioned_by = "Terraform"
  }
}