resource "aws_ecs_task_definition" "main" {
  family                   = local.name_prefix
  execution_role_arn       = aws_iam_role.exec.arn
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  tags                     = var.tags
  container_definitions = jsonencode([
    {
      name      = local.name_prefix,
      image     = "${var.image_repository_url}:${local.current_image_tag}"
      cpu       = var.container_cpu
      memory    = var.container_memory_hard
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "CURRENT_TAG"
          value = local.current_image_tag
        },
      ]
      secrets = [
        {
          name      = "SECRET_TEST"
          valueFrom = "${aws_ssm_parameter.deploy_tag.arn}"
        }
      ]
      mountPoints = []
      volumesFrom = []
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.main.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      # healthCheck = {
      #   command     = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}/ || exit 1"]
      #   interval    = 10
      #   timeout     = 2
      #   retries     = 2
      #   startPeriod = 40
      # }
    }
  ])

  depends_on = [ aws_ssm_parameter.deploy_tag ]
}