resource "aws_cloudwatch_log_group" "batch_event" {
  name              = local.event_log_group_name
  retention_in_days = var.log_retention_in_days

  tags = merge(module.this.tags, { Name = local.event_log_group_name })
}
