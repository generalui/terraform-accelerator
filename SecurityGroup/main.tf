# AWS Security Group
# See https://registry.terraform.io/modules/cloudposse/security-group/aws/2.2.0

module "security-group" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"

  # Security Group names must be unique within a VPC.
  # This module follows Cloud Posse naming conventions and generates the name
  # based on the inputs to the null-label module, which means you cannot
  # reuse the label as-is for more than one security group in the VPC.
  #
  # Add an attribute to give the Security Group a unique name
  attributes = var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  allow_all_egress              = var.allow_all_egress
  revoke_rules_on_delete        = var.revoke_rules_on_delete
  rule_matrix                   = var.rule_matrix
  rules                         = var.rules
  rules_map                     = var.rules_map
  security_group_create_timeout = var.security_group_create_timeout
  security_group_delete_timeout = var.security_group_delete_timeout
  vpc_id                        = var.vpc_id

  tags = var.tags == null ? var.context.tags : var.tags
}
