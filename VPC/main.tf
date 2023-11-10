# AWS VPC
# See https://registry.terraform.io/modules/cloudposse/vpc/aws/2.1.0

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.1.0"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  ipv4_primary_cidr_block          = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = var.tags == null ? var.context.tags : var.tags
}
