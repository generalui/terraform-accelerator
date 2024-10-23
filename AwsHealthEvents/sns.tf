data "aws_caller_identity" "this" {}

module "sns_kms_key" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//KmsKey?ref=1.0.0-KmsKey"
  count  = local.create_kms_key ? 1 : 0

  attributes = []
  context    = local.context.context

  alias               = "alias/health-events-sns"
  description         = "KMS key for the AWS Personal Health Dashboard Events SNS topic"
  enable_key_rotation = true
  policy              = local.create_kms_key ? data.aws_iam_policy_document.sns_kms_key_policy[0].json : ""
}

data "aws_iam_policy_document" "sns_kms_key_policy" {
  count = local.create_kms_key ? 1 : 0

  policy_id = "EventBridgeEncryptUsingKey"

  statement {
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

module "sns_topic" {
  source  = "cloudposse/sns-topic/aws"
  version = "0.20.1"

  attributes = []
  context    = local.context.context

  allowed_aws_services_for_sns_published = ["events.amazonaws.com"]
  kms_master_key_id                      = local.create_kms_key ? module.sns_kms_key[0].alias_name : var.kms_master_key_id
  sqs_dlq_enabled                        = false
  subscribers                            = var.subscribers
}

resource "aws_cloudwatch_event_target" "sns" {
  arn      = module.sns_topic.sns_topic.arn
  for_each = aws_cloudwatch_event_rule.health_events
  rule     = each.value.name
}
