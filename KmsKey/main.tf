# AWS KMS Key
# See https://registry.terraform.io/modules/cloudposse/kms-key/aws/0.12.1

module "kms_key" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.1"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  alias                   = var.alias
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  key_usage               = var.key_usage

  tags = var.tags == null ? var.context.tags : var.tags
}
