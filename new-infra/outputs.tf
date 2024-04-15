output "sts" {
  value = data.aws_caller_identity.current
}

output "lb_dns" {
  value = module.alb.alb_dns
}