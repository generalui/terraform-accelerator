output "arn" {
  description = "The ARN of the Elastic Container Registry"
  sensitive   = false
  value       = module.ecr.repository_arn
}

output "url" {
  description = "The URL of the repository"
  value       = module.ecr.repository_url
}
