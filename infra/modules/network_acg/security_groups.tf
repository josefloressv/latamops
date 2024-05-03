resource "aws_security_group" "vpcendpoints" {
  vpc_id = data.aws_vpc.main.id
  name   = "${local.name_prefix}-vpc-endpoint"

  ingress {
    description = "Allow HTTPS Inbound From Private Subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.private_subnet1_cidr, var.private_subnet2_cidr]

  }
  egress {
    description = "Allow all for egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, {
    Name = "${local.name_prefix}-vpc-endpoint"
  })
}