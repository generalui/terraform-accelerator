# Label
# Terraform Module to define a consistent naming convention by (namespace, stage, name, [attributes])
# See https://registry.terraform.io/modules/cloudposse/label/null/0.25.0

module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  tags = var.tags == null ? var.context.tags : var.tags
}
