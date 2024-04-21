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