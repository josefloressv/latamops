# deployments/ecs-fargate-cluster/terragrunt.hcl

include {
  path = find_in_parent_folders()
}

locals {
  enabled_regions = ["us-east-1a", "us-east-1b"]
  common_vars     = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
  # General
  aws_region = local.common_vars.aws_region

  # Cluster
  cluster_name                 = "cluster-app-${local.common_vars.environment}"
  base_tags                    = local.common_vars.base_tags
  cloudwatch_retention_in_days = 7
  cluster_tags = {
    Name = "cluster-app-${local.common_vars.environment}"
  }

  # VPC
  vpc_name               = "vpc-app-${local.common_vars.environment}"
  vpc_cidr               = "192.168.0.0/16"
  vpc_public_subnets     = ["192.168.1.0/24", "192.168.2.0/24"]
  vpc_public_subnets_azs = local.enabled_regions
  vpc_tags = {
    Name = "vpc-app-${local.common_vars.environment}"
  }

  # Security Group
  sg_alb_name = "alb-sg-${local.common_vars.environment}"
  sg_alb_ingress = [
    {
      description = "Allow port HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

      }, {
      description = "Allow port 3000 to communicate with the LB and the containers"
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["192.168.0.0/16"]

    }
  ]

  sg_alb_tags = {
    Name = "sg-alb-${local.common_vars.environment}"
    Info = "Allow HTTP traffic from anywhere"
  }

  # Load Balancer
  alb_name    = "alb-app-${local.common_vars.environment}"
  alb_subnets = local.enabled_regions
  alb_tags = {
    Name = "alb-app-${local.common_vars.environment}"
  }

  alb_default_listener_status_code = "404"
  alb_default_listener_message     = "Sorry, the page Not Found :/ att: the LB"
}
