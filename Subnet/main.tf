module "dynamic_subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.1"

  name      = var.name == null ? var.context.name : var.name
  namespace = var.name == null ? var.context.name : var.name
  stage     = var.name == null ? var.context.name : var.name

  availability_zones = var.availability_zones
  ipv4_cidr_block    = var.ipv4_cidr_block
  igw_id             = var.igw_id
  max_subnet_count   = var.max_subnet_count
  vpc_id             = var.vpc_id
}
