# General
variable "tags" {
  type = map(string)
}
# EC2 Lunch template
variable "lt_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "lt_ami_id" {
  type = string
}
# variable "lt_security_groups" {
#     type = list(string)
#     default = [""]
# }

# ASG
# https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_EnableMetricsCollection.html
variable "asg_enabled_metrics" {
  type    = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity",
  ]
}
variable "asg_min_size" {
  type    = number
  default = 1
}
variable "asg_max_size" {
  type    = number
  default = 1
}
variable "asg_vpc_id" {
  type = string
}
variable "private_subnets_ids" {
  type = list(string)
}
variable "public_subnets_cidr" {
  type = list(string)
}

variable "cp_instance_warmup_period" {
  type = number
  default = 30
}

variable "cp_min_scaling_step_size" {
  type = number
  default = 1
}

variable "cp_max_scaling_step_size" {
  type = number
  default = 2
}

variable "cp_target_capacity" {
  type = number
  default = 100
}