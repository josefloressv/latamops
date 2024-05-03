resource "aws_security_group" "default" {
  vpc_id = var.asg_vpc_id
  name   = "${local.name_prefix}-asg-default"

    ingress {
      description = "Allow HTTPS Inbound From ALB"
      from_port   = 1
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = var.public_subnets_cidr

    }
  egress {
    description = "Allow all for egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, {
    Name = "${local.name_prefix}-asg-default"
  })
}