module "aws_batch_compute" {
  depends_on = [module.vpc_endpoint_security_group]
  source     = "../"

  name    = "${module.this.name}-batch"
  context = module.this.context
  ecr_url = module.ecr.url
  ecr_tag = local.image_tag_name

  batch_failed_alarm_actions = [aws_sns_topic.health.arn]
  log_group_name             = aws_cloudwatch_log_group.batch.name
  log_retention_in_days      = 1

  launch_template_id = aws_launch_template.instance.id
  linux_parameters   = { sharedMemorySize = 8 }

  worker_environment_variables = {
    REGION = var.aws_region
    TEST   = "test value"
  }
  worker_security_group_ids = [module.vpc_endpoint_security_group.id]
  worker_subnet_ids         = module.subnet.private_subnet_ids
}

resource "aws_launch_template" "instance" {
  name = "${module.this.name}-ebs-memory"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs { volume_size = 30 }
  }

  tags = merge(module.this.tags, { Name = "${module.this.id}-batch" })
}
