# AWS VPC
# See https://registry.terraform.io/modules/cloudposse/iam-policy/aws/2.0.1

module "iam_policy" {
  source  = "cloudposse/iam-policy/aws"
  version = "2.0.1"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  description                   = var.description
  iam_policy                    = var.iam_policy
  iam_policy_enabled            = var.iam_policy_enabled
  iam_override_policy_documents = var.iam_override_policy_documents
  iam_source_json_url           = var.iam_source_json_url
  iam_source_policy_documents   = var.iam_source_policy_documents

  tags = var.tags == null ? var.context.tags : var.tags
}
