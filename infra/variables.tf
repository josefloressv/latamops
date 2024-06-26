# General
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "application" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

# Cluster

# EC2 Lunch template
variable "lt_instance_type" {
  type    = string
  default = "t3.small"
}

# Network
variable "vpc_cidr" {
  type = string
}
variable "private_subnet1_cidr" {
  type = string
}
variable "private_subnet2_cidr" {
  type = string
}
variable "public_subnet1_cidr" {
  type = string
}
variable "public_subnet2_cidr" {
  type = string
}

# DB
variable "database_name" {
  type = string
}

variable "database_master_username" {
  type = string
}

variable "database_master_password" {
  type    = string
  default = "petclinic"
}

variable "database_instance_class" {
  type = string
}

# ASG
variable "asg_min_size" {
  type = number
}
variable "asg_max_size" {
  type = number
}

# CP
variable "cp_instance_warmup_period" {
  type    = number
  default = 30
}

variable "cp_min_scaling_step_size" {
  type = number
}

variable "cp_max_scaling_step_size" {
  type = number
}

variable "cp_target_capacity" {
  type = number
}

# Task

variable "container_cpu" {
  type = number
}
variable "container_memory_hard" {
  type = number
}

# ECS
variable "task_min_number" {
  type = number
}

variable "task_max_number" {
  type = number
}
variable "health_check_grace_period_seconds" {
  type = number
}
variable "memory_target_threshold" {
  type = number
}
variable "memory_scaleout_cooldown_seconds" {
  type = number
}
variable "memory_scalein_cooldown_seconds" {
  type = number
}

variable "cpu_target_threshold" {
  type = number
}

variable "cpu_scaleout_cooldown_seconds" {
  type = number
}

variable "cpu_scalein_cooldown_seconds" {
  type = number
}
