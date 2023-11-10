output "arn" {
  description = "ARN of the lambda function"
  value       = module.lambda_function.arn
}

output "function_name" {
  description = "Lambda function name"
  value       = module.lambda_function.function_name
}

output "invoke_arn" {
  description = "Invoke ARN of the lambda function"
  value       = module.lambda_function.invoke_arn
}

output "qualified_arn" {
  description = "ARN identifying your Lambda Function Version (if versioning is enabled via publish = true)"
  value       = module.lambda_function.qualified_arn
}

output "role_arn" {
  description = "Lambda IAM role ARN"
  value       = module.lambda_function.role_arn
}

output "role_name" {
  description = "Lambda IAM role name"
  value       = module.lambda_function.role_name
}
