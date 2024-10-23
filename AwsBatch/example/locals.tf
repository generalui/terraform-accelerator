locals {
  account_id     = data.aws_caller_identity.current.account_id
  ecr_name       = "batch-example-ecr"
  ecr_address    = "${local.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  image_tag_name = "example-python-batch-${time_static.activation_date.unix}"
  image_url      = "${module.ecr.url}:${local.image_tag_name}"
}
