locals {
  account_id  = data.aws_caller_identity.current.account_id
  ecr_address = "${local.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  ecr_name    = module.this.id
  image_tag   = "example-${module.this.name}-${time_static.activation_date.unix}"
  image_url   = "${local.ecr_address}/${local.ecr_name}:${local.image_tag}"
}
