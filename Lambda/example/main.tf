# This example creates an AWS Lambda.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment_name
    }
  }
}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "handler.js"
  output_path = "lambda_function.zip"
}

# This is the "context". It uses the Label module to help ensure consistant naming conventions.
module "this" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//Label?ref=1.0.0"

  attributes = var.attributes
  name       = var.project
  namespace  = var.namespace
  stage      = var.environment_name

  tags = var.tags

  context = var.context
}

module "inside_policy" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//IamPolicy?ref=1.0.0"

  # Add the project to the name so it is the same as `local.policy_name_inside`
  name    = "${var.project}-inside"
  context = module.this.context

  description = "The policy attached inside the Lambda module"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "example"
    statements = [
      {
        sid       = "DescribeEc2"
        effect    = "Allow"
        actions   = ["ec2:Describe*"]
        resources = ["*"]
      }
    ]
  }]
  iam_policy_enabled = true
}

module "lambda" {
  depends_on = [module.inside_policy]
  source     = "../"

  name    = "example-lambda"
  context = module.this.context

  filename               = join("", data.archive_file.lambda_zip.*.output_path)
  function_name          = module.this.id
  handler                = "handler.handler"
  runtime                = "nodejs14.x"
  ephemeral_storage_size = 1024

  custom_iam_policy_arns = [
    "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
    local.policy_arn_inside
    # module.inside_policy.arn, # This will result in an error message and is why we use local.policy_arn_inside
  ]
}

# Variables

locals {
  # The policy name has to be at least 20 characters
  policy_name_inside = "${module.this.id}-inside"
  policy_arn_prefix  = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:policy"
  policy_arn_inside  = "${local.policy_arn_prefix}/${local.policy_name_inside}"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = <<-EOT
    ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,
    in the order they appear in the list. New attributes are appended to the
    end of the list. The elements of the list are joined by the `delimiter`
    and treated as a single ID element.
    EOT
}

variable "aws_profile" {
  type        = string
  description = "The AWS profile name as set in the shared credentials file."
  default     = "default"
}

variable "aws_region" {
  type        = string
  description = "The AWS region."
  default     = "us-east-2"
}

variable "context" {
  type = any
  default = {
    attributes = []
    name       = null
    namespace  = null
    stage      = null
    tags       = {}
  }
  description = <<-EOT
    Single object for setting entire context at once.
    See description of individual variables for details.
    Leave string and numeric variables as `null` to use default value.
    Individual variable settings (non-null) override settings in context object,
    except for attributes, tags, and additional_tag_map, which are merged.
  EOT
}

variable "environment_name" {
  type        = string
  description = "Current environment, e.g. 'prod', 'staging', 'dev', 'QA', 'performance'"
  default     = "poc"
  validation {
    condition     = length(var.environment_name) < 8
    error_message = "The environment_name value must be less than 8 characters"
  }
}

variable "namespace" {
  type        = string
  default     = "xmpl"
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "project" {
  type        = string
  description = "Name of the project as a whole"
  default     = "MyProject"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.
    EOT
}
