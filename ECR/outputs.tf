output "arn" {
  value       = module.ecr.repository_arn
  description = "ARN of first repository created"
}

output "arn_map" {
  value       = module.ecr.repository_arn_map
  description = "Map of repository names to repository ARNs"
}

output "id" {
  value       = module.ecr.registry_id
  description = "Registry ID"
}

output "name" {
  value       = module.ecr.repository_name
  description = "Name of first repository created"
}

output "url" {
  value       = module.ecr.repository_url
  description = "URL of first repository created"
}

output "url_map" {
  value       = module.ecr.repository_url_map
  description = "Map of repository names to repository URLs"
}
