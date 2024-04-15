
resource "aws_subnet" "private1" {
  vpc_id            = data.aws_vpc.main.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = "${var.aws_region}a"

  tags = merge(var.tags, {
    Name = "${local.name_prefix}-private-1"
  })
}

resource "aws_subnet" "private2" {
  vpc_id            = data.aws_vpc.main.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = "${var.aws_region}b"

  tags = merge(var.tags, {
    Name = "${local.name_prefix}-private-2"
  })
}

resource "aws_subnet" "public1" {
  vpc_id            = data.aws_vpc.main.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "${var.aws_region}a"

  tags = merge(var.tags, {
    Name = "${local.name_prefix}-public-1"
  })
}

resource "aws_subnet" "public2" {
  vpc_id            = data.aws_vpc.main.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "${var.aws_region}b"

  tags = merge(var.tags, {
    Name = "${local.name_prefix}-public-2"
  })
}
