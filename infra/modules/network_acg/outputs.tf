output "vpc_id" {
  value = data.aws_vpc.main.id
}
output "vpc_arn" {
  value = data.aws_vpc.main.arn
}
output "private_subnet_ids" {
  value = [aws_subnet.private1.id, aws_subnet.private2.id]
}
output "public_subnet_ids" {
  value = [aws_subnet.public1.id, aws_subnet.public2.id]
}
