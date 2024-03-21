# General
variable "aws_region" {
  type = string
}

variable "base_tags" {
  type        = map(string)
  description = "The base tags for the stack"
}

# New Relic IAM Role
variable "aws_nerelic_role_name" {
  type        = string
  description = "The name of the IAM role to use for the New Relic agent"
}

variable "newrelic_aws_account_id" {
  type        = number
  description = "value of the New relic AWS account ID"
}

variable "newrelic_external_id" {
  type        = number
  description = "value of the New relic External ID"
}

# New Relic Agent
variable "aws_nragent_role_name" {
  type        = string
  description = "The name of the IAM role to use for the New Relic agent"
}

variable "nr_license_secret_name" {
  type        = string
  description = "The name of the secret containing the New Relic license key"
}

