output "ecs_cluster_arn" {
  value = aws_ecs_cluster.main.arn
}
output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_cluster_capacity_provider_name" {
  value = aws_ecs_capacity_provider.main.name
}