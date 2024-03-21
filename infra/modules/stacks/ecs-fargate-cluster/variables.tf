# General
variable "aws_region" {
  type = string
}

variable "base_tags" {
  type        = map(string)
  description = "The base tags for the stack"
}

# Cluster
variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
}

variable "cluster_tags" {
  type        = map(string)
  description = "The tags for the cluster"
}

variable "cloudwatch_retention_in_days" {
  type        = number
  description = "The retention in days of CloudWatch logs"
}

# VPC
variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}
variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "The public subnets for the VPC"
}

variable "vpc_public_subnets_azs" {
  type        = list(string)
  description = "The availability zones for the public subnets"
}

variable "vpc_tags" {
  type        = map(string)
  description = "The tags for the VPC"
}

# Security Group

variable "sg_alb_name" {
  type        = string
  description = "Provides the name of the Security Group"
}

variable "sg_alb_ingress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "Provides the inbound rules for the Security Group"
}

variable "sg_alb_tags" {
  type        = map(string)
  description = "Provides the tags for the Security Group"
}

# Load Balancer
variable "alb_name" {
  type        = string
  description = "Provides the name of the Load Balancer"
}

variable "alb_subnets" {
  type        = list(string)
  description = "Provides the subnets for the Load Balancer"
}

variable "alb_tags" {
  type        = map(string)
  description = "Provides the tags for the Load Balancer"
}

variable "alb_default_listener_status_code" {
  type        = string
  description = "Provides the default status code for the Load Balancer"
}

variable "alb_default_listener_message" {
  type        = string
  description = "Provides the default message for the Load Balancer"
}
