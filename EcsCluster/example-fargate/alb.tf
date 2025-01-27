module "alb" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//ALB?ref=1.0.1-ALB"

  context = module.this.context

  access_logs_enabled                     = false
  alb_access_logs_s3_bucket_force_destroy = true
  deletion_protection_enabled             = false
  health_check_port                       = local.container_port
  security_group_ids                      = [module.vpc.default_security_group_id]
  subnet_ids                              = module.subnet.public_subnet_ids
  target_group_name                       = local.target_group_name
  target_group_port                       = local.container_port
  vpc_id                                  = module.vpc.id

  stickiness = {
    cookie_duration = 600
    enabled         = true
  }

  target_group_additional_tags = merge(module.this.tags, { Name = local.target_group_name })
}
