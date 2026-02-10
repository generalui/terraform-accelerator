# Terraform State - AWS S3 Backend
# See https://registry.terraform.io/modules/cloudposse/tfstate-backend/aws/1.3.0

# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.8.0"

  context = module.this.context

  billing_mode                       = var.billing_mode
  force_destroy                      = var.force_destroy
  logging                            = var.logging
  permissions_boundary               = var.permissions_boundary
  profile                            = var.profile
  role_arn                           = var.role_arn
  s3_bucket_name                     = var.s3_bucket_name
  s3_replica_bucket_arn              = var.s3_replica_bucket_arn
  s3_replication_enabled             = var.s3_replication_enabled
  source_policy_documents            = var.source_policy_documents
  terraform_backend_config_file_name = "backend.tf"
  terraform_backend_config_file_path = var.terraform_backend_config_file_path
  terraform_state_file               = var.terraform_state_file
}
