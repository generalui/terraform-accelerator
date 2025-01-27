locals {
  account_id           = data.aws_caller_identity.current.account_id
  aws_region           = data.aws_region.default.name
  ecr_image_url        = "${var.ecr_url}:${var.ecr_tag}"
  event_log_group_name = "/aws/events/${var.log_group_name}"
  environment_variables_formatted_for_batch = [for key, value in var.worker_environment_variables : {
    name  = key
    value = value
  }]
  event_log_group_arn = "arn:aws:logs:${local.aws_region}:${local.account_id}:log-group:${local.event_log_group_name}"
}
