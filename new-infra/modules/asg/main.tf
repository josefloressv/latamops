resource "aws_autoscaling_group" "cluster_asg" {
  name = "${local.name_prefix}-v${aws_launch_template.main.latest_version}"

  force_delete = true

  # https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#waiting-for-capacity
  wait_for_capacity_timeout = "20m"

  # Required for Capacity Providers
  protect_from_scale_in = true

  # Standard configuration
  vpc_zone_identifier = var.asg_subnets
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size

  enabled_metrics = length(var.asg_enabled_metrics) > 0 ? var.asg_enabled_metrics : null

  termination_policies = [
    "OldestLaunchTemplate",
    "OldestInstance",
    "ClosestToNextInstanceHour",
    "Default"
  ]

  dynamic "tag" {
    for_each = var.tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  launch_template {
    id      = aws_launch_template.main.id
    version = aws_launch_template.main.latest_version
  }

  lifecycle {
    create_before_destroy = true

    ignore_changes = [
      desired_capacity
    ]
  }

  timeouts {
    delete = "1h"
  }
}