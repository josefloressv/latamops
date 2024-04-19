# Network
module "net" {
  source               = "./modules/network_acg"
  aws_region           = var.aws_region
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

# ASG and Cluster
module "asg" {
  source              = "./modules/asg"
  lt_ami_id           = module.ami.id
  private_subnets_ids = module.net.private_subnet_ids
  public_subnets_cidr = local.public_subnets_cidr
  asg_vpc_id          = module.net.vpc_id
  tags                = local.common_tags
}

# ALB
module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.net.vpc_id
  public_subnets = module.net.public_subnet_ids
  tags           = local.common_tags
}

module "ecr" {
  source      = "./modules/ecr"
  tags        = local.common_tags
  name_prefix = local.name_prefix
}

module "ecs" {
  source         = "./modules/ecs"
  aws_account_id = local.aws_account_id
  aws_region     = var.aws_region
  # image_repository_url = module.ecr.repository_url
  image_repository_url   = "533267318629.dkr.ecr.us-east-1.amazonaws.com/ecsdemo-frontend"
  container_cpu          = 25
  container_memory_hard  = 1024
  container_port         = 3000
  capacity_provider_name = module.asg.ecs_cluster_capacity_provider_name
  ecs_cluster_id         = module.asg.ecs_cluster_arn
  vpc_id                 = module.net.vpc_id
  alb_http_listener_arn  = module.alb.alb_http_listener_arn
  tags                   = local.common_tags
}