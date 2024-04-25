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

# ECR
module "ecr_petclinic" {
  source     = "./modules/ecr"
  tags       = local.common_tags
  name_sufix = "-petclinic"
}

# DB
module "db" {
  source             = "./modules/rds-aurora"
  tags               = local.common_tags
  vpc_id             = module.net.vpc_id
  availability_zones = ["us-east-1b", "us-east-1c", "us-east-1d"]
  database_name      = var.database_name
  master_username    = var.database_master_username
  master_password    = var.database_master_password
  instance_class     = var.database_instance_class
}

# AMI
module "ami" {
  source = "./modules/ami_search"
}

# ASG and Cluster
module "asg_ecs" {
  source                    = "./modules/asg_ecs"
  lt_ami_id                 = module.ami.id
  private_subnets_ids       = module.net.private_subnet_ids
  public_subnets_cidr       = local.public_subnets_cidr
  asg_vpc_id                = module.net.vpc_id
  tags                      = local.common_tags
  asg_min_size              = var.asg_min_size
  asg_max_size              = var.asg_max_size
  cp_instance_warmup_period = var.cp_instance_warmup_period
  cp_min_scaling_step_size  = var.cp_min_scaling_step_size
  cp_max_scaling_step_size  = var.cp_max_scaling_step_size
  cp_target_capacity        = var.cp_target_capacity
}

# ALB
module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.net.vpc_id
  public_subnets = module.net.public_subnet_ids
  tags           = local.common_tags
}

# ECS App
module "app_petclinic" {
  source                 = "./modules/app"
  aws_account_id         = local.aws_account_id
  aws_region             = var.aws_region
  image_repository_url   = module.ecr_petclinic.repository_url
  container_cpu          = var.container_cpu
  container_memory_hard  = var.container_memory_hard
  container_port         = 8080
  health_check_path      = "/actuator/health"
  capacity_provider_name = module.asg_ecs.ecs_cluster_capacity_provider_name
  ecs_cluster_id         = module.asg_ecs.ecs_cluster_arn
  ecs_cluster_name       = module.asg_ecs.ecs_cluster_name
  vpc_id                 = module.net.vpc_id
  alb_http_listener_arn  = module.alb.alb_http_listener_arn
  tags                   = local.common_tags
  name_sufix             = "-petclinic"
  depends_on             = [module.asg_ecs]
}
