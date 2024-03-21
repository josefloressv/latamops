module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  name           = var.vpc_name
  cidr           = var.vpc_cidr
  azs            = var.vpc_public_subnets_azs
  public_subnets = var.vpc_public_subnets

  tags = merge(
    local.tags,
    var.vpc_tags
  )

}

data "aws_vpc" "fargate" {
  id = module.vpc.vpc_id
}
