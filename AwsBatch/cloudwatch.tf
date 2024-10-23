locals {
  metric_name = "${module.this.id}-batch-failed-jobs"
}

resource "aws_cloudwatch_event_rule" "batch" {
  name           = "${module.this.id}-batch"
  description    = "Send batch status to CloudWatch Logs"
  event_bus_name = "default"
  # `event_pattern` is a json object that describes the event pattern
  event_pattern = jsonencode({
    "detail-type" = ["Batch Job State Change"]
    detail        = { jobDefinition = [{ wildcard = "${aws_batch_job_definition.batch_job_definition.arn_prefix}:*" }] }
    source        = ["aws.batch"]
  })
  state = "ENABLED"

  tags = merge(module.this.tags, { Name = "${module.this.id}-batch" })
}

resource "aws_cloudwatch_event_target" "batch_to_cloudwatch_logs" {
  arn            = local.event_log_group_arn
  event_bus_name = "default"
  rule           = aws_cloudwatch_event_rule.batch.name
  target_id      = "${module.this.id}-batch-to-cloudwatch-logs"
}

resource "aws_cloudwatch_log_metric_filter" "batch_failed_jobs" {
  depends_on     = [aws_cloudwatch_log_group.batch_event]
  name           = local.metric_name
  pattern        = "{ $.detail.status = \"FAILED\" }"
  log_group_name = local.event_log_group_name

  metric_transformation {
    name      = local.metric_name
    namespace = aws_cloudwatch_metric_alarm.batch_failed_jobs.namespace
    value     = 1
  }
}

resource "aws_cloudwatch_metric_alarm" "batch_failed_jobs" {
  alarm_description         = "Monitoring for failed AWS Batch jobs"
  alarm_name                = "${module.this.id}-batch-failed-jobs"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  insufficient_data_actions = []
  metric_name               = local.metric_name
  namespace                 = "BatchFailedJobs"
  period                    = 60
  statistic                 = "Sum"
  threshold                 = 1

  alarm_actions = var.batch_failed_alarm_actions

  tags = merge(module.this.tags, { Name = "${module.this.id}-batch-failed-jobs" })
}
