locals {
  name_prefix       = "${var.tags.Application}-${var.tags.Environment}${var.name_sufix}"
  ssm_prefix_path   = join("/", [var.tags.Application, "${var.tags.Environment}${var.name_sufix}"])
  current_image_tag = aws_ssm_parameter.deploy_tag.insecure_value
  ecs_target_resource_id = "service/${var.ecs_cluster_name}/${aws_ecs_service.service.name}"
  task_placement_strategy_rules = [
    {
      "field" : "attribute:ecs.availability-zone",
      "type" : "spread"
    },
    {
      "field" : "memory",
      "type" : "binpack"
    },
    {
      "field" : "cpu",
      "type" : "binpack"
    }
  ]
}