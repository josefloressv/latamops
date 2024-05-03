variable "tags" {
  type = map(string)
}

variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "image_repository_url" {
  type = string
}

variable "container_cpu" {
  type = number
}
variable "container_memory_hard" {
  type = number
}

variable "container_port" {
  type = number
}

variable "capacity_provider_name" {
  type = string
}

variable "ecs_cluster_id" {
  type = string
}
variable "ecs_cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "alb_http_listener_arn" {
  type = string
}

variable "name_sufix" {
  type = string
}

variable "health_check_path" {
  type = string
}

# Auto Scaling
variable "task_min_number" {
  type = number
}

variable "task_max_number" {
  type = number
}

variable "cpu_target_threshold" {
  type = number
}

variable "cpu_scalein_cooldown_seconds" {
  type = number
}

variable "cpu_scaleout_cooldown_seconds" {
  type = number
}


variable "memory_target_threshold" {
  type = number
}

variable "memory_scalein_cooldown_seconds" {
  type = number
}

variable "memory_scaleout_cooldown_seconds" {
  type = number
}

variable "health_check_grace_period_seconds" {
  type    = number
}