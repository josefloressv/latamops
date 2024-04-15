resource "aws_security_group" "default" {
  vpc_id = var.asg_vpc_id
  name   = "${local.name_prefix}-asg-default"

#   ingress {
#     description = "Allow HTTPS Inbound From VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [var.vpc_cidr]

#   }
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