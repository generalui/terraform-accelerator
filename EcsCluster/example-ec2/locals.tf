locals {
  account_id        = data.aws_caller_identity.current.account_id
  container_port    = 5000
  desired_count     = 1
  ecr_address       = "${local.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  ecr_name          = module.this.id
  ecs_health_emails = ["jon.ryser+test_ecs_cluster_example@genui.com"]
  image_tag_name    = "example-${module.this.name}-${time_static.activation_date.unix}"
  image_url         = "${local.ecr_address}/${local.ecr_name}:${local.image_tag_name}"
  log_group_name    = module.this.id
  target_group_name = "${module.this.name}-example"
}
