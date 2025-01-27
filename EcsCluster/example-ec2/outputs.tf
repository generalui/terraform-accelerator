output "cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs_cluster.cluster_name
}

output "ecr_url" {
  description = "The URL of the ECR"
  value       = module.ecr.url
}

output "service_name" {
  description = "ECS Service name"
  value       = module.ecs_cluster.service_name
}

output "alb_name" {
  description = "ALB name"
  value       = module.alb.name
}
