# New relic setup

## New relic requirements
- IAM role to establish trust
  - NR Account ID 754728514883
  - NR External ID 3588847 (change between each NR account)
    - Go to NR> Infrastructure> AWS> Add an AWS account> Use metric stream
  - Policy required: ReadOnlyAccess 
- Configures CloudWatch metric stream and Kinesis Data Firehose to send metrics to New Relic
  - Using a CloudFormation template provided by New Relic
    - New Relic Ingest [License Key](https://docs.newrelic.com/docs/apis/intro-apis/new-relic-api-keys/)
      - Go to NR> Your User Area> AWS> API Keys

## Let's do it!
Step 01 provision the new relic role
```sh
terragrunt aply -auto-approve

# Copy the IAM role ARN and pasted it into the setup wizard, Step 5
```
Step 02 Add an AWS account to New Relic

- Go to NR> Infrastructure> AWS> Add an AWS account> Use metric stream
- Click on next until the Step 5
  - Here you need to paste the IAM role ARN

Step 03 Configure AWS Metric Stream (6 min aprox)

Use the automated process via CloudFormation: 
[Use the CloudFormation Template](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?templateURL=https://nr-downloads-main.s3.amazonaws.com/cloud_integrations/aws/cloudformation/MetricStreams_CloudFormation.yml&stackName=NewRelic-Metric-Stream&param_NewRelicDatacenter=US)

This will provisioned:
- CloudWatch metric stream
- Kinesis Data Firehose with an IAM role and S3 bucket
- New Relic Ingest License Key

Note: after the process is done, you need to wait  at least 5  minutes to see the metrics in New Relic.

Step 03 Configure Fargate

Manualy provision the fargate role
https://docs.newrelic.com/docs/infrastructure/elastic-container-service-integration/installation/install-ecs-integration/#manual-install
```sh
aws ssm put-parameter \
  --name "/newrelic-infra/ecs/license-key" \
  --type SecureString \
  --description 'New Relic license key for ECS monitoring' \
  --value "8a24fb1b39c65bcb027a5dd2725a7db1b78791dd"

aws iam create-policy \
    --policy-name "NewRelicSSMLicenseKeyReadAccess" \
    --policy-document "{"Version"\"2012-10-17","Statement":[{"Effect":"Allow","Action":["ssm:GetParameters"],"Resource":["/newrelic-infra/ecs/license-key"]}]}"
    --description "Provides read access to the New Relic SSM license key parameter"

aws iam create-role \
  --role-name "NewRelicECSTaskExecutionRole" \
  --assume-role-policy-document '{"Version":"2008-10-17","Statement":[{"Sid":"","Effect":"Allow","Principal":{"Service":"ecs-tasks.amazonaws.com"},"Action":"sts:AssumeRole"}]}' \
  --description "ECS task execution role for New Relic infrastructure"

aws iam attach-role-policy \
    --role-name "NewRelicECSTaskExecutionRole" \
    --policy-arn "POLICY_ARN"

curl -O https://download.newrelic.com/infrastructure_agent/integrations/ecs/newrelic-infra-ecs-fargate-example-latest.json
```

Via CloudFormation:

https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?templateURL=https://nr-downloads-main.s3.amazonaws.com/infrastructure_agent/integrations/ecs/cloudformation/task/master.yaml&stackName=NewRelicECSIntegration
