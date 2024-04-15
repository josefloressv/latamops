resource "aws_launch_template" "main" {
  name_prefix = local.name_prefix
  description = "ASG template for ${local.name_prefix}"

  image_id = var.lt_ami_id
  instance_type = var.lt_instance_type
#   key_name = "" # allow access only through SSM

  user_data = base64encode(templatefile("${path.module}/templates/user_data.tpl", {
    cluster_name       = var.cluster_name
  }))

  ebs_optimized = true
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type = "gp3"
      volume_size = 30 #GiB

      # Performance.
      iops       = 3000
      throughput = 125

      encrypted = true
      delete_on_termination = true
    }
  }

  instance_initiated_shutdown_behavior = "terminate"

  iam_instance_profile {
    name = aws_iam_instance_profile.lt.name
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
     security_groups             = [aws_security_group.default.id]
  }

  # EC2 detailed monitoring
  monitoring {
    enabled = true
  }

  #  Instance Metadata Service
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags = "enabled"
  }

  hibernation_options {
    configured = false
  }

  # AWS Nitro Secure Enclave
  enclave_options {
    enabled = false
  }

  # EC2 Instance tags
  tag_specifications {
    resource_type = "instance"

    # Merge a "Name" tag into the list of tags passed-in.
    tags = merge(
      var.tags,
      {
        "Name" = "${local.name_prefix}"
      },
    )
  }

  # EBS Volume tags
  tag_specifications {
    resource_type = "volume"
    tags          = var.tags
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true

    ignore_changes = [
      tags,
      tag_specifications,
      description
    ]
  }

}