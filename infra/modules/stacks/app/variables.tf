# General
variable "aws_region" {
  type = string
}

variable "aws_vpc_id" {
  type = string
}

variable "base_tags" {
  type        = map(string)
  description = "The base tags for the stack"
}

# Task Definition
variable "task_name" {
  type        = string
  description = "The name of the task definition"
}

variable "task_cpu" {
  type        = number
  description = "The number of cpu units to allocate to the task"
}

variable "task_memory" {
  type        = number
  description = "The amount of memory to allocate to the task"
}

variable "task_cpu_architecture" {
  type        = string
  description = "The cpu architecture to use for the task"
}

variable "task_os_family" {
  type        = string
  description = "The OS family to use for the task"
}

variable "container_name" {
  type        = string
  description = "The name of the container"
}

variable "container_image_name" {
  type        = string
  description = "The image to use for the container"
}

variable "container_port" {
  type        = number
  description = "The port to expose on the container"
}

variable "container_cpu" {
  type        = number
  description = "The number of cpu units to allocate to the container"
}

variable "task_tags" {
  type        = map(string)
  description = "The tags to apply to the task"
}

# Service
variable "service_name" {
  type        = string
  description = "The name of the service"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "service_desired_count" {
  type        = number
  description = "The number of tasks to run"
}

variable "service_sg_ids" {
  type        = list(string)
  description = "The security group ids to use for the service"
}

variable "service_tags" {
  type        = map(string)
  description = "The tags to apply to the service"
}

# Target Group
variable "tg_name" {
  type        = string
  description = "The name of the target group"
}

variable "tg_port" {
  type        = number
  description = "The port to use for the target group"
}

variable "tg_health_check_path" {
  type        = string
  description = "The path to use for the target group"
}

variable "tg_alb_name" {
  type        = string
  description = "The name of the ALB"
}

variable "tg_tags" {
  type        = map(string)
  description = "The tags to apply to the target group"
}

# Listener
variable "listener_context_path" {
  type        = string
  description = "The context path to use for the listener"
}

# ECR
variable "ecr_repo_name" {
  type        = string
  description = "The name of the ECR repository"
}

variable "ecr_repo_tag_mutability" {
  type        = string
  description = "The tag mutability of the ECR repository"
}

variable "ecr_repo_tags" {
  type        = map(string)
  description = "The tags to apply to the ECR repository"
}

variable "ecr_repo_policy_expiration_days" {
  type        = number
  description = "The expiration date for the ECR repository policy"
}

variable "ecr_repo_policy_description" {
  type        = string
  description = "The description for the ECR repository policy"
}