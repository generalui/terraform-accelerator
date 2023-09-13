# AWS VPC
# See https://registry.terraform.io/modules/cloudposse/vpc/aws/latest

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.1.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  ipv4_primary_cidr_block = "10.0.0.0/16"

  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = var.tags
}
