output "fargate-vpc-id" {
  value = data.aws_vpc.fargate.id
}

output "fargate-vpc-subnets-id" {
  value = module.vpc.public_subnets
}

output "fargate-cluster-name" {
  value = aws_ecs_cluster.fargate-cluster.name
}

output "fargate-cluster-arn" {
  value = aws_ecs_cluster.fargate-cluster.id
}

output "fargate-alb-name" {
  value = aws_lb.fargate-alb.name
}

output "fargate-alb-url" {
  value = "http://${aws_lb.fargate-alb.dns_name}"
}

output "fargate-alb-arn" {
  value = aws_lb.fargate-alb.arn
}

output "fargate-alb-listener-arn" {
  value = aws_lb_listener.web-listener.arn
}

output "fargate-sg-id" {
  value = aws_security_group.sg-fargate.id
}
