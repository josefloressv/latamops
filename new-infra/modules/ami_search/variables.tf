variable "ami_name_filter" {
  type    = string
  default = "al2023-ami-ecs-hvm-2023.*" # for basic EC2: al2023-ami-2023.*
  # amzn2-ami-ecs-hvm-2.0.20240409-x86_64-ebs
  # ami-021fe45d6043e82c8

  # al2023-ami-ecs-hvm-2023.0.20240409-kernel-6.1-x86_64
  # ami-0af9e559c6749eb48

}