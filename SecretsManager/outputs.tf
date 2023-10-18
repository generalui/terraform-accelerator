output "name" {
  value       = module.secretsmanager.name
  description = "Name of the secret"
}

output "id" {
  value       = module.secretsmanager.id
  description = "ID of the secret"
}

output "arn" {
  value       = module.secretsmanager.arn
  description = "ARN of the secret"
}

output "version_id" {
  value       = module.secretsmanager.version_id
  description = "The unique identifier of the version of the secret."
}

output "kms_key_arn" {
  value       = module.secretsmanager.kms_key_arn
  description = "KMS key ARN"
}

output "kms_key_id" {
  value       = module.secretsmanager.kms_key_id
  description = "KMS key ID"
}

output "kms_key_alias_arn" {
  value       = module.secretsmanager.kms_key_alias_arn
  description = "KMS key alias ARN"
}

output "kms_key_alias_name" {
  value       = module.secretsmanager.kms_key_alias_name
  description = "KMS key alias name"
}
