# Deployment

Provision AWS S3 bucket:

```sh
aws s3api create-bucket --bucket goweb-terraform-state-bucket
#replace the bucket name in terragrunt.hcl

```

Configure environment variables:

```sh
export AWS_ACCESS_KEY_ID=<your-access-key-id>
export AWS_SECRET_ACCESS_KEY=<your-secret-access-key>
export AWS_DEFAULT_REGION=us-east-1
```

# Resources
* [Using the awslogs log driver](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_awslogs.html#specify-log-config)

# Errors and troubleshooting

*Error: Task stopped ResourceInitializationError*

```
Stopped reason
ResourceInitializationError: unable to pull secrets or registry auth: execution resource retrieval failed: unable to retrieve ecr registry auth: service call has been retried 3 time(s): RequestError: send request failed caused by: Post https://api.ecr.us-east-1.amazonaws.com/: dial tcp 52.46.145.142:443: i/o timeout

```

Solution: This solution needed Public IP active for the container https://aws.amazon.com/premiumsupport/knowledge-center/ecs-unable-to-pull-secrets/


*Error: WARN[] No double-slash (//) found - on remote modules without submodules*

Solution: Added triple slash at the end
```hcl
terraform {
  #source = "${get_parent_terragrunt_dir()}/../modules/stacks/${local.stack_name}/"
  source = "${get_parent_terragrunt_dir()}/../modules/stacks/${local.stack_name}///"
}
```

Error
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
Error saving credentials: error storing credentials - err: exit status 1, out: `Post "http://ipc/registry/credstore-updated": dial unix backend.sock: connect: no such file or directory`

Solution: start docker service

Error Docker push
joseflores@Joses-MacBook-Air app % docker push 265967435636.dkr.ecr.us-east-1.amazonaws.com/nodeapp:latest

The push refers to repository [265967435636.dkr.ecr.us-east-1.amazonaws.com/nodeapp]
7b7af8f3542c: Retrying in 1 second 
6b00d6c7cc07: Retrying in 1 second 
25b1fb969b53: Retrying in 1 second 
252b87a53059: Retrying in 1 second 
76a9d2fd4fa2: Retrying in 1 second 
5d3e392a13a0: Waiting 
EOF

Solution:
I was pushing to an ECR that does not created yet. I fixed
docker tag app01-dev:latest 265967435636.dkr.ecr.us-east-1.amazonaws.com/app01-dev:latest

GHA Remote state S3 bucket goweb-terraform-state-bucket is out of date. Would you like Terragrunt to update it? (y/n) time=2022-08-13T03:33:07Z level=error msg=EOF
time=2022-08-13T03:33:07Z level=error msg=Unable to determine underlying exit code, so Terragrunt will exit with error code 1
Error: Process completed with exit code 1.

Solution:
terragrunt init --terragrunt-non-interactive
https://davidbegin.github.io/terragrunt/terragrunt_details/cli-options.html
