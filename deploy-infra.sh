#! /usr/bin/env bash
set -o nounset -o pipefail -o errexit;

# Source the .env file
. .env

# Validate arguments
if [ -z "$1" ]; then
  echo "Error: Environment argument is missing. Use ./deploy-infra.sh dev plan"
  exit 1
elif [ -z "$2" ]; then
  echo "Error: Terraform Action argument is missing. Use ./deploy-infra.sh dev plan"
  exit 1
elif ! [[ "$1" =~ ^($VALID_ENVIRONNMENTS)$ ]]; then
  echo "Error: Invalid environment \"$1\" . Must be $VALID_ENVIRONNMENTS."
  exit 1
elif ! [[ "$2" =~ ^(plan|apply|destroy)$ ]]; then
  echo "Error: Invalid Terraform action \"$1\" . Must be plan|apply|destroy."
  exit 1
fi

# Define Dynamic environment variables
ENV=$1
TFACTION=$2
VAR_FILE="env/${ENV}.tfvars"
export TF_VAR_environment=${ENV}
export AWS_REGION=$TF_VAR_aws_region

# Change to the infrastructure directory
cd "$INFRA_DIR"

# Validate Terrafor vairables file
if [ ! -f "$VAR_FILE" ]; then
  echo "Error: 'env/${ENV}.tfvars' file doesn't exists!"
  exit 1
fi

# ----------------------------------------------------------------
# Terraform commands
# ----------------------------------------------------------------

# Format
terraform fmt

# Initialize
echo "Initializing Terraform"
terraform init \
  -input=false \
  -reconfigure
  # -backend-config="bucket=${TF_STATE_BUCKET_NAME}"\
  # -backend-config="key=${TF_STATE_BACKEND_KEY}"\
  # -backend-config="region=${TF_STATE_BACKEND_REGION}"

# Validate
echo "Terraform Validate"
terraform validate

# Create or switch Terraform workspace
echo "Creating or switching Terraform workspace"
CUR_WORKSPACE=$(terraform workspace show)
if [ "_${CUR_WORKSPACE}" != "_${ENV}" ]; then
  (terraform workspace list | grep "$ENV" \
    && terraform workspace select "$ENV") \
    || terraform workspace new "$ENV"
fi

# Plan
echo "Running Terraform Plan"
terraform plan \
  -input=false \
  -var-file="$VAR_FILE"

# Apply
if [ "_${TFACTION}" == "_apply" ]; then
  echo "Running Terraform Apply"
  terraform apply \
    -input=false \
    -var-file="$VAR_FILE"
fi