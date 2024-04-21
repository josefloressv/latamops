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
module "asg_ecs" {
  source              = "./modules/asg_ecs"
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

module "ecr_petclinic" {
  source     = "./modules/ecr"
  tags       = local.common_tags
  name_sufix = "-petclinic"
}

module "app_petclinic" {
  source                 = "./modules/app"
  aws_account_id         = local.aws_account_id
  aws_region             = var.aws_region
  image_repository_url   = module.ecr_petclinic.repository_url
  container_cpu          = 25
  container_memory_hard  = 1024
  container_port         = 8080
  health_check_path      = "/actuator/health"
  capacity_provider_name = module.asg_ecs.ecs_cluster_capacity_provider_name
  ecs_cluster_id         = module.asg_ecs.ecs_cluster_arn
  vpc_id                 = module.net.vpc_id
  alb_http_listener_arn  = module.alb.alb_http_listener_arn
  tags                   = local.common_tags
  name_sufix             = "-petclinic"
  depends_on             = [module.asg_ecs]
}
