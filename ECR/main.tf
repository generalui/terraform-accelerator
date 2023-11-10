# A Terraform module for creating a cross-account-accessible ECR repository.
# See https://registry.terraform.io/modules/cloudposse/ecr/aws/0.40.0

module "ecr" {
  source  = "cloudposse/ecr/aws"
  version = "0.40.0"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  enable_lifecycle_policy       = var.enable_lifecycle_policy
  encryption_configuration      = var.encryption_configuration
  force_delete                  = var.force_delete
  image_names                   = var.image_names
  image_tag_mutability          = var.image_tag_mutability
  max_image_count               = var.max_image_count
  organizations_full_access     = var.organizations_full_access
  organizations_push_access     = var.organizations_push_access
  organizations_readonly_access = var.organizations_readonly_access
  principals_full_access        = var.principals_full_access
  principals_push_access        = var.principals_push_access
  principals_readonly_access    = var.principals_readonly_access
  principals_lambda             = var.principals_lambda
  protected_tags                = var.protected_tags
  scan_images_on_push           = var.scan_images_on_push
  use_fullname                  = var.use_fullname

  tags = var.tags == null ? var.context.tags : var.tags
}
