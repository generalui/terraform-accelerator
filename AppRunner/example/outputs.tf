output "service_url" {
  description = "App Runner service URL (HTTPS)."
  value       = module.apprunner.service_url
}

output "service_id" {
  description = "App Runner service ID."
  value       = module.apprunner.service_id
}

output "service_status" {
  description = "App Runner service status."
  value       = module.apprunner.service_status
}

output "ecr_repository_url" {
  description = "ECR repository URL."
  value       = module.ecr.url
}
