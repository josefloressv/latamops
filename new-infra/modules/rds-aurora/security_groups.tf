resource "aws_security_group" "default" {
  vpc_id = var.vpc_id
  name   = "${local.name_prefix}-rds"

  ingress {
    description = "Allow MySQL Inbound From Internet"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    description = "Allow all for egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}