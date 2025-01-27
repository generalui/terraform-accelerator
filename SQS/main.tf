# AWS SQS Queue
# See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue

locals {
  enabled = var.enabled == null ? var.context.enabled : var.enabled
  name    = var.use_fullname ? module.this.id : module.this.name
}

# This is the "context". It uses the Label module to help ensure consistant naming conventions.
module "this" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//Label?ref=1.0.1-Label"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  enabled    = var.enabled == null ? var.context.enabled : var.enabled
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage
  tags       = var.tags == null ? var.context.tags : var.tags

  context = var.context
}

resource "aws_sqs_queue" "default" {
  count = local.enabled ? 1 : 0

  name                              = var.fifo_queue ? "${local.name}.fifo" : local.name
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  message_retention_seconds         = var.message_retention_seconds
  max_message_size                  = var.max_message_size
  delay_seconds                     = var.delay_seconds
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  policy                            = try(var.policy[0], null)
  redrive_allow_policy              = var.redrive_allow_policy
  redrive_policy                    = try(var.redrive_policy[0], null)
  fifo_queue                        = var.fifo_queue
  fifo_throughput_limit             = try(var.fifo_throughput_limit[0], null)
  content_based_deduplication       = var.content_based_deduplication
  kms_master_key_id                 = try(var.kms_master_key_id[0], null)
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  deduplication_scope               = try(var.deduplication_scope[0], null)

  tags = module.this.tags
}
