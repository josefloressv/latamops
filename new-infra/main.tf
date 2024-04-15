# Network
module "net" {
  source               = "./modules/network_acg"
  vpc_cidr             = var.vpc_cidr
  private_subnet1_cidr = var.private_subnet1_cidr
  private_subnet2_cidr = var.private_subnet2_cidr
  public_subnet1_cidr  = var.public_subnet1_cidr
  public_subnet2_cidr  = var.public_subnet2_cidr
  tags                 = local.common_tags
}

# AMI
module "ami" {
  source = "./modules/ami_search"
}

# Cluster
# ASG
module "asg" {
  source      = "./modules/asg"
  lt_ami_id   = module.ami.id
  asg_subnets = module.net.private_subnet_ids
  asg_vpc_id  = module.net.vpc_id
  tags        = local.common_tags
}