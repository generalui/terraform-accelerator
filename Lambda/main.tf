# AWS VPC
# See https://registry.terraform.io/modules/cloudposse/lambda-function/aws/0.5.3

module "lambda_function" {
  source  = "cloudposse/lambda-function/aws"
  version = "0.5.3"

  attributes = var.attributes == null ? var.context.attributes : var.attributes
  name       = var.name == null ? var.context.name : var.name
  namespace  = var.namespace == null ? var.context.namespace : var.namespace
  stage      = var.stage == null ? var.context.stage : var.stage

  architectures                      = var.architectures
  cloudwatch_lambda_insights_enabled = var.cloudwatch_lambda_insights_enabled
  cloudwatch_logs_kms_key_arn        = var.cloudwatch_logs_kms_key_arn
  cloudwatch_logs_retention_in_days  = var.cloudwatch_logs_retention_in_days
  custom_iam_policy_arns             = var.custom_iam_policy_arns
  dead_letter_config_target_arn      = var.dead_letter_config_target_arn
  description                        = var.description
  ephemeral_storage_size             = var.ephemeral_storage_size
  filename                           = var.filename
  function_name                      = var.function_name
  handler                            = var.handler
  iam_policy_description             = var.iam_policy_description
  image_config                       = var.image_config
  image_uri                          = var.image_uri
  kms_key_arn                        = var.kms_key_arn
  lambda_at_edge_enabled             = var.lambda_at_edge_enabled
  lambda_environment                 = var.lambda_environment
  layers                             = var.layers
  memory_size                        = var.memory_size
  package_type                       = var.package_type
  permissions_boundary               = var.permissions_boundary
  publish                            = var.publish
  reserved_concurrent_executions     = var.reserved_concurrent_executions
  runtime                            = var.runtime
  s3_bucket                          = var.s3_bucket
  s3_key                             = var.s3_key
  s3_object_version                  = var.s3_object_version
  source_code_hash                   = var.source_code_hash
  ssm_parameter_names                = var.ssm_parameter_names
  timeout                            = var.timeout
  tracing_config_mode                = var.tracing_config_mode
  vpc_config                         = var.vpc_config

  tags = var.tags == null ? var.context.tags : var.tags
}
