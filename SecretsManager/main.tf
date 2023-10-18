# AWS Secrets Manager
# See https://registry.terraform.io/modules/SweetOps/secretsmanager/aws/0.5.0

module "secretsmanager" {
  source  = "SweetOps/secretsmanager/aws"
  version = "0.5.0"

  name      = var.name == null ? var.context.name : var.name
  namespace = var.namespace == null ? var.context.namespace : var.namespace
  stage     = var.stage == null ? var.context.stage : var.stage

  description                    = var.description
  force_overwrite_replica_secret = var.force_overwrite_replica_secret
  kms_key                        = var.kms_key
  kms_key_id                     = var.kms_key_id
  policy                         = var.policy
  recovery_window_in_days        = var.recovery_window_in_days
  replicas                       = var.replicas
  rotation                       = var.rotation
  secret_version                 = var.secret_version

  tags = var.tags == null ? var.context.tags : var.tags
}
