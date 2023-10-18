# AWS Key Pair
# See https://registry.terraform.io/modules/cloudposse/key-pair/aws/0.20.0

module "key_pair" {
  source  = "cloudposse/key-pair/aws"
  version = "0.20.0"

  name      = var.name == null ? var.context.name : var.name
  namespace = var.namespace == null ? var.context.namespace : var.namespace
  stage     = var.stage == null ? var.context.stage : var.stage

  generate_ssh_key          = var.generate_ssh_key
  private_key_extension     = var.private_key_extension
  public_key_extension      = var.public_key_extension
  ssh_key_algorithm         = var.ssh_key_algorithm
  ssh_public_key_file       = var.ssh_public_key_file
  ssh_public_key_path       = var.ssh_public_key_path
  ssm_parameter_enabled     = var.ssm_parameter_enabled
  ssm_parameter_path_prefix = var.ssm_parameter_path_prefix

  tags = var.tags == null ? var.context.tags : var.tags
}
