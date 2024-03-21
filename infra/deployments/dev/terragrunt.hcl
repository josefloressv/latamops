# deployments/root.hcl

locals {
  common_vars              = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  root_deployments_dir     = get_parent_terragrunt_dir()
  relative_deployment_path = path_relative_to_include()
  deployment_path_stacks   = compact(split("/", local.relative_deployment_path))
  stack_name               = local.deployment_path_stacks[0]
  component                = reverse(local.deployment_path_stacks)[0]
}
# Default the stack each deployment deploys based on its directory structure
# Can be overridden by redefining this block in a child terragrunt.hcl
terraform {
  source = "${local.root_deployments_dir}/../../modules/stacks/${local.stack_name}///"
}

remote_state {
  backend = "s3"
  config = {
    bucket = "goweb-terraform-state-bucket-${local.common_vars.environment}"
    key    = "${local.stack_name}/${local.component}-terraform.tfstate" # ${path_relative_to_include()}/terraform.tfstate
    region = local.common_vars.aws_region
    encrypt = true
  }
}
