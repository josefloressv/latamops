resource "aws_ecs_task_definition" "base" {
  family                   = var.task_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.container_image_name}:latest"
      cpu       = var.container_cpu
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
          hostPort      = var.container_port
        }
      ]
      logConfiguration = {
          logDriver = "awslogs"
          options = {
              awslogs-group = "/aws/ecs/${var.cluster_name}"
              awslogs-region = var.aws_region
              awslogs-stream-prefix = var.service_name
          }
      }      
    }
  ])

  runtime_platform {
    operating_system_family = var.task_os_family
    cpu_architecture        = var.task_cpu_architecture
  }

  tags = merge(
    local.tags,
    var.task_tags
  )
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.base.arn
  desired_count   = var.service_desired_count

  load_balancer {
    target_group_arn = aws_lb_target_group.tg-app.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count]
  }

  launch_type = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.all.ids
    security_groups  = var.service_sg_ids
    assign_public_ip = true
  }

}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [var.aws_vpc_id]
  }
}

data "aws_caller_identity" "current" {}

