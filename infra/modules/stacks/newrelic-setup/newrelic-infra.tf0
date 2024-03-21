resource "aws_ecs_task_definition" "newrelic" {
  family                   = var.task_name
  requires_compatibilities = ["EXTERNAL","FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.nragent.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.nr_docker_image
      cpu       = 200
      memory    = 384
      essential = true
    }
  ])

  environment = [
    {
      name  = "NRIA_VERBOSE"
      value = "0"
    },
    {
      name  = "NRIA_PASSTHROUGH_ENVIRONMENT",
      value = "ECS_CONTAINER_METADATA_URI,ECS_CONTAINER_METADATA_URI_V4"
    },
    {
      name  = "NRIA_OVERRIDE_HOST_ROOT",
      value = "/host"
    }
  ]

  secrets = [
    {
      name      = "NRIA_LICENSE_KEY",
      valueFrom = data.aws_secretsmanager_secret.newrelic.arn
    }
  ]

  tags = merge(
    local.tags,
    var.task_tags
  )
}

