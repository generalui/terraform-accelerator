resource "aws_sns_topic" "health" {
  name = "${module.this.id}-health"
  tags = merge(module.this.tags, { Name = "${module.this.id}-health" })
}

resource "aws_sns_topic_subscription" "health" {
  count     = length(var.health_emails)
  topic_arn = aws_sns_topic.health.arn
  protocol  = "email"
  endpoint  = var.health_emails[count.index]
}
