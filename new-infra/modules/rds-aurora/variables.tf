variable "tags" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type = string
}

variable "database_name" {
  type = string
}

variable "instance_class" {
    type = string
}