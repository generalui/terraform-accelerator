output "access_key_id" {
  sensitive   = true
  value       = module.s3_bucket.access_key_id
  description = <<-EOT
    The access key ID, if `var.user_enabled && var.access_key_enabled`.
    While sensitive, it does not need to be kept secret, so this is output regardless of `var.store_access_key_in_ssm`.
    EOT
}

output "access_key_id_ssm_path" {
  value       = module.s3_bucket.access_key_id_ssm_path
  description = "The SSM Path under which the S3 User's access key ID is stored"
}

output "arn" {
  value       = module.s3_bucket.bucket_arn
  description = "Bucket ARN"
}

output "domain_name" {
  value       = module.s3_bucket.bucket_domain_name
  description = "FQDN of bucket"
}

output "enabled" {
  value       = module.s3_bucket.enabled
  description = "Is module enabled"
}

output "id" {
  value       = module.s3_bucket.bucket_id
  description = "Bucket Name (aka ID)"
}

output "replication_role_arn" {
  value       = module.s3_bucket.replication_role_arn
  description = "The ARN of the replication IAM Role"
}

output "region" {
  value       = module.s3_bucket.bucket_region
  description = "Bucket region"
}

output "regional_domain_name" {
  value       = module.s3_bucket.bucket_regional_domain_name
  description = "The bucket region-specific domain name"
}

output "secret_access_key" {
  sensitive   = true
  value       = module.s3_bucket.secret_access_key
  description = <<-EOT
    The secret access key will be output if created and not stored in SSM. However, the secret access key, if created,
    will be written to the Terraform state file unencrypted, regardless of any other settings.
    See the [Terraform documentation](https://www.terraform.io/docs/state/sensitive-data.html) for more details.
    EOT
}

output "secret_access_key_ssm_path" {
  value       = module.s3_bucket.secret_access_key_ssm_path
  description = "The SSM Path under which the S3 User's secret access key is stored"
}

output "user_arn" {
  value       = module.s3_bucket.user_arn
  description = "The ARN assigned by AWS for the user"
}

output "user_enabled" {
  value       = module.s3_bucket.user_enabled
  description = "Is user creation enabled"
}

output "user_name" {
  value       = module.s3_bucket.user_name
  description = "Normalized IAM user name"
}

output "user_unique_id" {
  value       = module.s3_bucket.user_unique_id
  description = "The user unique ID assigned by AWS"
}

output "website_domain" {
  value       = module.s3_bucket.bucket_website_domain
  description = "The bucket website domain, if website is enabled"
}

output "website_endpoint" {
  value       = module.s3_bucket.bucket_website_endpoint
  description = "The bucket website endpoint, if website is enabled"
}
