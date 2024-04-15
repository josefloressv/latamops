output "sts" {
  value = data.aws_caller_identity.current
}
output "region" {
  value = data.aws_region.current
}