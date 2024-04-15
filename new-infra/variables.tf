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
