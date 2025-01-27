# AWS Subnets
# See https://registry.terraform.io/modules/cloudposse/dynamic-subnets/aws/2.4.1

module "dynamic_subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.1"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  availability_zones      = var.availability_zones
  ipv4_cidr_block         = var.ipv4_cidr_block
  igw_id                  = var.igw_id
  max_subnet_count        = var.max_subnet_count
  nat_elastic_ips         = var.nat_elastic_ips
  nat_gateway_enabled     = var.nat_gateway_enabled
  nat_instance_enabled    = var.nat_instance_enabled
  private_subnets_enabled = var.private_subnets_enabled
  public_subnets_enabled  = var.public_subnets_enabled
  vpc_id                  = var.vpc_id
}
