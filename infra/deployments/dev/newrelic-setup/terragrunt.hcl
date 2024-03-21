# deployments/newrelic-setup/terragrunt.hcl

include {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
  # General
  aws_region     = local.common_vars.aws_region

  # New Relic role    
  base_tags               = local.common_vars.base_tags
  aws_nerelic_role_name   = "NewRelicInfrastructure-Integrations"
  newrelic_aws_account_id = 754728514883
  newrelic_external_id    = 3588847

  # New Relic Agent role
  aws_nragent_role_name   = "NewRelicECSIntegration"
  nr_license_secret_name = "NewRelicLicenseKeySecret"
}
