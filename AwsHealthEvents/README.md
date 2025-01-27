# AWS Health Events

This module creates an EventBridge (formerly CloudWatch Events) rules for AWS Personal Health Dashboard Events and an SNS topic.
EventBridge will publish messages to this SNS topic, which can be subscribed to using this module as well.
Since AWS Personal Health Dashboard is a global service,
but since the KMS key and SNS topic are regional, this module is technically regional but only needs to be deployed once per account.
See the [example](./example/).

Based on the Cloud Posse module, see more here: <https://github.com/cloudposse/terraform-aws-health-events>

## Module Specs

[SPECS.md](./SPECS.md)
