# AWS Route53 hostname
# See https://registry.terraform.io/modules/cloudposse/route53-cluster-hostname/aws/0.13.0

module "route53_hostname" {
  source  = "cloudposse/route53-cluster-hostname/aws"
  version = "0.13.0"

  enabled = var.enabled

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  dns_name     = var.dns_name
  private_zone = var.private_zone
  records      = var.records
  ttl          = var.ttl
  type         = var.type
  zone_id      = var.zone_id
  zone_name    = var.zone_name
  zone_tags    = var.zone_tags
  zone_vpc_id  = var.zone_vpc_id


  tags = var.tags == null ? var.context.tags : var.tags
}
