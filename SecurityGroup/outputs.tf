output "arn" {
  description = "The ARN of the security group"
  value       = module.security_group.security_group_arn
}

output "id" {
  description = "The ID of the security group"
  value       = module.security_group.security_group_id
}

output "vpc_id" {
  description = "The VPC ID"
  value       = module.security_group.security_group_vpc_id
}

output "owner_id" {
  description = "The owner ID"
  value       = module.security_group.security_group_owner_id
}

output "name" {
  description = "The name of the security group"
  value       = module.security_group.security_group_name
}

output "description" {
  description = "The description of the security group"
  value       = module.security_group.security_group_description
}
