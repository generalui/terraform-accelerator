# AWS IAM Role
# See https://registry.terraform.io/modules/cloudposse/iam-role/aws/0.19.0

module "iam_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.19.0"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  assume_role_actions      = var.assume_role_actions
  assume_role_conditions   = var.assume_role_conditions
  instance_profile_enabled = var.instance_profile_enabled
  managed_policy_arns      = var.managed_policy_arns
  max_session_duration     = var.max_session_duration
  path                     = var.path
  permissions_boundary     = var.permissions_boundary
  policy_description       = var.policy_description
  policy_documents         = var.policy_documents
  policy_document_count    = var.policy_document_count
  policy_name              = var.policy_name
  principals               = var.principals
  role_description         = var.role_description
  tags_enabled             = var.tags_enabled
  use_fullname             = var.use_fullname

  tags = var.tags == null ? var.context.tags : var.tags
}
