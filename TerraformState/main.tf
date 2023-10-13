# Terraform State - AWS S3 Backend
# See https://registry.terraform.io/modules/cloudposse/tfstate-backend/aws/1.1.1

# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.1.1"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  force_destroy                      = var.force_destroy
  profile                            = var.profile
  role_arn                           = var.role_arn
  terraform_backend_config_file_name = "backend.tf"
  terraform_backend_config_file_path = var.terraform_backend_config_file_path
  terraform_state_file               = var.terraform_state_file
}
