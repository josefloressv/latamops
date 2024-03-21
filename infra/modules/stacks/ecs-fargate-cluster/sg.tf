# Security Group
resource "aws_security_group" "sg-fargate" {
  vpc_id = data.aws_vpc.fargate.id
  name   = var.sg_alb_name

  dynamic "ingress" {
    for_each = var.sg_alb_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  egress {
    description = "Allow all for egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    local.tags,
    var.sg_alb_tags
  )
}