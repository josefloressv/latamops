locals {
  name_prefix         = "${var.application}-${var.environment}"
  aws_account_id      = data.aws_caller_identity.current.account_id
  public_subnets_cidr = [var.public_subnet1_cidr, var.public_subnet2_cidr]
  common_tags = {
    Application    = var.application
    Environment    = var.environment
    Provisioned_by = "Terraform"
  }
}