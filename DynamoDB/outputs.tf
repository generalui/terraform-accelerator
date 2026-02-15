output "id" {
  description = "Name of the DynamoDB table (unique within the region)."
  value       = module.this.enabled ? aws_dynamodb_table.this[0].id : null
}

output "arn" {
  description = "ARN of the DynamoDB table."
  value       = module.this.enabled ? aws_dynamodb_table.this[0].arn : null
}

output "name" {
  description = "Name of the DynamoDB table."
  value       = module.this.enabled ? aws_dynamodb_table.this[0].name : null
}

output "stream_arn" {
  description = "ARN of the DynamoDB stream (when stream_enabled is true)."
  value       = module.this.enabled && var.stream_enabled ? aws_dynamodb_table.this[0].stream_arn : null
}

output "stream_label" {
  description = "Timestamp of the stream (when stream_enabled is true)."
  value       = module.this.enabled && var.stream_enabled ? aws_dynamodb_table.this[0].stream_label : null
}
