# AWS Health Events
# Based on the CloudePosse module https://github.com/cloudposse/terraform-aws-health-events

resource "aws_cloudwatch_event_rule" "health_events" {
  for_each    = local.event_rules
  name        = module.this[each.key].id
  description = each.value.description
  tags        = module.this[each.key].tags

  event_pattern = jsonencode(
    {
      "source"      = ["aws.health"],
      "detail-type" = ["AWS Health Event"]
      "detail" = {
        "service"           = [each.value.event_rule_pattern.detail.service]
        "eventTypeCategory" = [each.value.event_rule_pattern.detail.event_type_category]
        "eventTypeCode"     = each.value.event_rule_pattern.detail.event_type_codes
      }
    }
  )
}
