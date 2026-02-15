output "table_name" {
  description = "DynamoDB table name."
  value       = module.dynamodb.name
}

output "table_arn" {
  description = "DynamoDB table ARN."
  value       = module.dynamodb.arn
}

output "table_id" {
  description = "DynamoDB table ID (same as name within the region)."
  value       = module.dynamodb.id
}
