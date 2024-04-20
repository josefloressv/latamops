locals {
  name_prefix       = "${var.tags.Application}-${var.tags.Environment}${var.name_sufix}"
  ssm_prefix_path   = join("/", [var.tags.Application, "${var.tags.Environment}${var.name_sufix}"])
  current_image_tag = aws_ssm_parameter.deploy_tag.insecure_value
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