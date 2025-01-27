# AWS S3 Bucket
# See https://registry.terraform.io/modules/cloudposse/s3-bucket/aws/4.0.1

module "s3_bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "4.0.1"

  context = module.this.context

  access_key_enabled                      = var.access_key_enabled
  allowed_bucket_actions                  = var.allowed_bucket_actions
  allow_encrypted_uploads_only            = var.allow_encrypted_uploads_only
  allow_ssl_requests_only                 = var.allow_ssl_requests_only
  bucket_key_enabled                      = var.bucket_key_enabled
  block_public_acls                       = var.block_public_acls
  block_public_policy                     = var.block_public_policy
  bucket_name                             = var.bucket_name
  cors_configuration                      = var.cors_configuration
  force_destroy                           = var.force_destroy
  ignore_public_acls                      = var.ignore_public_acls
  kms_master_key_arn                      = var.kms_master_key_arn
  lifecycle_configuration_rules           = var.lifecycle_configuration_rules
  logging                                 = var.logging
  object_lock_configuration               = var.object_lock_configuration
  privileged_principal_arns               = var.privileged_principal_arns
  privileged_principal_actions            = var.privileged_principal_actions
  restrict_public_buckets                 = var.restrict_public_buckets
  s3_object_ownership                     = var.s3_object_ownership
  s3_replica_bucket_arn                   = var.s3_replica_bucket_arn
  s3_replication_enabled                  = var.s3_replication_enabled
  s3_replication_permissions_boundary_arn = var.s3_replication_permissions_boundary_arn
  s3_replication_rules                    = var.s3_replication_rules
  s3_replication_source_roles             = var.s3_replication_source_roles
  sse_algorithm                           = var.sse_algorithm
  source_policy_documents                 = var.source_policy_documents
  ssm_base_path                           = var.ssm_base_path
  store_access_key_in_ssm                 = var.store_access_key_in_ssm
  transfer_acceleration_enabled           = var.transfer_acceleration_enabled
  user_enabled                            = var.user_enabled
  user_permissions_boundary_arn           = var.user_permissions_boundary_arn
  versioning_enabled                      = var.versioning_enabled
  website_configuration                   = var.website_configuration
  website_redirect_all_requests_to        = var.website_redirect_all_requests_to
}
