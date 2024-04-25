resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public1.id

  tags = merge(var.tags, {
    Name = "${local.name_prefix}-nat-for-private"
  })
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # depends_on = [aws_internet_gateway.main]
}
resource "aws_eip" "nat" {
  domain = "vpc"
}

