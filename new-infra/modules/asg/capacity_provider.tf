# Create the ASG and attach to the ASG
resource "aws_ecs_capacity_provider" "main" {
  name = aws_autoscaling_group.main.name

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.main.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      instance_warmup_period    = 30
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 3
      target_capacity           = 100
      status                    = "ENABLED"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Attach CP to the ECS cluster
resource "aws_ecs_cluster_capacity_providers" "attach" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = [
    aws_ecs_capacity_provider.main.name
  ]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.main.name
    weight            = 1
    base              = 0
  }

}
