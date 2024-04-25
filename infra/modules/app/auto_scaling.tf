resource "aws_appautoscaling_target" "ecs_target" {
  min_capacity = var.task_min_number
  max_capacity = var.task_max_number
  resource_id  = local.ecs_target_resource_id

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "cpu" {
  name        = "${local.name_prefix}-cpu-scaling"
  policy_type = "TargetTrackingScaling"
  resource_id = local.ecs_target_resource_id

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.cpu_target_threshold
    scale_in_cooldown  = var.cpu_scalein_cooldown_seconds
    scale_out_cooldown = var.cpu_scaleout_cooldown_seconds
  }

  depends_on = [
    aws_appautoscaling_target.ecs_target,
  ]
}

resource "aws_appautoscaling_policy" "memory" {
  name        = "${local.name_prefix}-memory-scaling"
  policy_type = "TargetTrackingScaling"
  resource_id = local.ecs_target_resource_id

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.memory_target_threshold
    scale_in_cooldown  = var.memory_scalein_cooldown_seconds
    scale_out_cooldown = var.memory_scaleout_cooldown_seconds
  }

  depends_on = [
    aws_appautoscaling_target.ecs_target,
  ]
}
