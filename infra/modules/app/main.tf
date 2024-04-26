resource "aws_ecs_service" "service" {
  name            = local.name_prefix
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.main.arn

  enable_ecs_managed_tags = true
  scheduling_strategy     = "REPLICA"
  propagate_tags          = "SERVICE"
  tags                    = var.tags

  desired_count                      = var.task_min_number
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  force_new_deployment               = false
  wait_for_steady_state              = false

  # iam_role = "" > AWSServiceRoleForECS alrady created

  capacity_provider_strategy {
    capacity_provider = var.capacity_provider_name
    weight            = 1
    base              = 0
  }

  # https://www.terraform.io/docs/providers/aws/r/ecs_service.html#ordered_placement_strategy-1
  dynamic "ordered_placement_strategy" {
    for_each = local.task_placement_strategy_rules
    content {
      type  = ordered_placement_strategy.value["type"]
      field = ordered_placement_strategy.value["field"]
    }
  }

  # https://www.terraform.io/docs/providers/aws/r/ecs_service.html#load_balancer-1
  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = local.name_prefix
    container_port   = var.container_port
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      desired_count,
      # task_definition,
      capacity_provider_strategy
    ]
  }
}