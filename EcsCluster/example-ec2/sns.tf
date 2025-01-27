resource "aws_sns_topic" "ecs_healthcheck" {
  name = "${module.this.id}-healthcheck"
  tags = merge(module.this.tags, { Name = "${module.this.id}-healthcheck" })
}

resource "aws_sns_topic_subscription" "ecs_health" {
  count     = length(local.ecs_health_emails)
  topic_arn = aws_sns_topic.ecs_healthcheck.arn
  protocol  = "email"
  endpoint  = local.ecs_health_emails[count.index]
}
