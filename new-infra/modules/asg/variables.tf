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
variable "asg_enabled_metrics" {
  type    = list(string)
  default = []
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