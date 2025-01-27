output "instance_id" {
  value       = try(module.rds.instance_id, null)
  description = "ID of the instance"
}

output "instance_arn" {
  value       = try(module.rds.instance_arn, null)
  description = "ARN of the instance"
}

output "instance_address" {
  value       = try(module.rds.instance_address, null)
  description = "Address of the instance"
}

output "instance_endpoint" {
  value       = try(module.rds.instance_endpoint, null)
  description = "DNS Endpoint of the instance"
}

output "subnet_group_id" {
  value       = try(module.rds.subnet_group_id, null)
  description = "ID of the created Subnet Group"
}

output "security_group_id" {
  value       = try(module.rds.security_group_id, null)
  description = "ID of the Security Group"
}

output "parameter_group_id" {
  value       = try(module.rds.parameter_group_id, null)
  description = "ID of the Parameter Group"
}

output "option_group_id" {
  value       = try(module.rds.option_group_id, null)
  description = "ID of the Option Group"
}

output "hostname" {
  value       = try(module.rds.hostname, null)
  description = "DNS host name of the instance"
}

output "resource_id" {
  value       = try(module.rds.resource_id, null)
  description = "The RDS Resource ID of this instance."
}
