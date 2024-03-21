# deployments/app/terragrunt.hcl

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

dependencies {
  paths = ["${get_parent_terragrunt_dir()}/../ecs-fargate-cluster"]
}

inputs = {
  # General
  aws_region     = local.common_vars.aws_region
  aws_vpc_id     = trimspace(run_cmd("terragrunt", "output", "--raw", "fargate-vpc-id", "--terragrunt-working-dir", "${get_parent_terragrunt_dir()}/../ecs-fargate-cluster"))
  base_tags      = local.common_vars.base_tags

  # Task Definition defaults
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size
  task_cpu              = "256" # .25 vCPU
  task_memory           = "1024"
  task_cpu_architecture = "ARM64" # "X86_64"
  task_os_family        = "LINUX" # "WINDOWS"

  # Container defaults
  container_cpu = "256" # .25 vCPU

  # Service defaults
  cluster_name          = trimspace(run_cmd("terragrunt", "output", "--raw", "fargate-cluster-name", "--terragrunt-working-dir", "${get_parent_terragrunt_dir()}/../ecs-fargate-cluster"))
  service_sg_ids        = [trimspace(run_cmd("terragrunt", "output", "--raw", "fargate-sg-id", "--terragrunt-working-dir", "${get_parent_terragrunt_dir()}/../ecs-fargate-cluster"))]
  service_desired_count = 2

  # Target group and listener defaults
  tg_alb_name = "alb-app-${local.common_vars.environment}"
  tg_port     = "80"

  # ECR defaults
  ecr_repo_tag_mutability         = "MUTABLE"
  ecr_repo_policy_expiration_days = 7
  ecr_repo_policy_description     = "Expire images older than 7 days"
  ecr_repo_tags = {
    Policy = "7 days retention policy applied to all images in this repo"
  }

}
