# deployments/app/app01/terragrunt.hcl

include "root" {
  path = find_in_parent_folders()
}

include "app" {
  path = find_in_parent_folders("app.hcl")
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  app_name    = "app01"
}

inputs = {
  # ECR
  ecr_repo_name = "${local.app_name}-${local.common_vars.environment}"

  # Task definition
  task_name = "${local.app_name}-${local.common_vars.environment}"
  task_tags = {
    "Name" : "${local.app_name}-${local.common_vars.environment}",
    "Language" : "nodejs",
  }
  task_cpu_architecture = "X86_64" # "ARM64", X86_64

  # Container definition
  container_name       = "${local.app_name}-${local.common_vars.environment}"
  container_image_name = "${local.app_name}-${local.common_vars.environment}"
  container_port       = "3000"

  # Service
  service_name          = "${local.app_name}-${local.common_vars.environment}"
  service_desired_count = 2
  service_tags = {
    "Name" : "${local.app_name}-${local.common_vars.environment}"
  }

  # Target group and listener
  tg_name               = "tg-${local.app_name}-${local.common_vars.environment}"
  listener_context_path = "/app01*"
  tg_health_check_path  = "/app01/health"
  tg_tags = {
    "Name" : "tg-${local.app_name}-${local.common_vars.environment}"
  }
}
