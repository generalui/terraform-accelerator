output "service_id" {
  description = "App Runner service ID (unique within the region)."
  value       = module.this.enabled ? aws_apprunner_service.this[0].service_id : null
}

output "service_arn" {
  description = "ARN of the App Runner service."
  value       = module.this.enabled ? aws_apprunner_service.this[0].arn : null
}

output "service_url" {
  description = "Subdomain URL that App Runner generated for this service (HTTPS)."
  value       = module.this.enabled ? aws_apprunner_service.this[0].service_url : null
}

output "service_name" {
  description = "Name of the App Runner service."
  value       = module.this.enabled ? aws_apprunner_service.this[0].service_name : null
}

output "service_status" {
  description = "Current state of the App Runner service."
  value       = module.this.enabled ? aws_apprunner_service.this[0].status : null
}

output "vpc_connector_arn" {
  description = "ARN of the VPC connector (if created by this module)."
  value       = local.create_vpc_connector ? aws_apprunner_vpc_connector.this[0].arn : null
}

output "access_role_arn" {
  description = "ARN of the IAM access role used for ECR pull (if created by this module)."
  value       = local.create_access_role ? module.apprunner_access_role[0].arn : null
}

output "custom_domain_certificate_validation_records" {
  description = "Certificate validation records for the custom domain (add CNAME to DNS)."
  value       = (module.this.enabled && var.custom_domain_name != null && var.custom_domain_name != "" && length(aws_apprunner_custom_domain_association.this) > 0) ? aws_apprunner_custom_domain_association.this[0].certificate_validation_records : []
}
