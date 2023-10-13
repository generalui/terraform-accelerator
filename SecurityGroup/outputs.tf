output "arn" {
  description = "The created Security Group ARN (null if using existing security group)"
  value       = module.security_group.arn
}

output "id" {
  description = "The created or target Security Group ID"
  value       = module.security_group.id
}

output "name" {
  description = "The created Security Group Name (null if using existing security group)"
  value       = module.security_group.name
}

output "rules_terraform_ids" {
  description = "List of Terraform IDs of created `security_group_rule` resources, primarily provided to enable `depends_on`"
  value       = module.security_group.rules_terraform_ids
}
