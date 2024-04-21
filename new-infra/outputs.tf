output "sts" {
  value = data.aws_caller_identity.current
}

output "lb_dns" {
  value = module.alb.alb_dns
}

output "ecr_petclinic" {
  value = module.ecr_petclinic.repository_url
}