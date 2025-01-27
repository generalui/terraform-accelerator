# This example creates a Role.

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

data "aws_region" "current" {}

# This is the "context". It uses the Label module to help ensure consistant naming conventions.
module "this" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//Label?ref=1.0.1-Label"

  attributes = var.attributes
  name       = var.project
  namespace  = var.namespace
  stage      = var.environment_name

  tags = var.tags

  context = var.context
}

module "policy" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamPolicy?ref=1.0.1-IamPolicy"

  iam_policy_enabled = true
  name               = "ssm-port-forwarding"
  context            = module.this.context

  description = "Allows port forwarding"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "example"
    statements = [
      {
        sid     = "StartSsmSession"
        effect  = "Allow"
        actions = ["ssm:StartSession"]
        resources = [
          "arn:aws:ssm:${local.region}::document/AWS-StartPortForwardingSessionToRemoteHost"
        ]
      }
    ]
  }]
}

module "lambda_logging_policy" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamPolicy?ref=1.0.1-IamPolicy"

  iam_policy_enabled = true
  name               = "lambda-logging"
  context            = module.this.context

  description = "Pipeline: IAM policy for logging from lambdas"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "LambdaLogging"
    statements = [{
      sid    = "Logging"
      effect = "Allow"
      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      resources = ["arn:aws:logs:*:*:*"]
    }]
  }]
}

module "lambda_access_s3_policy" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamPolicy?ref=1.0.1-IamPolicy"

  iam_policy_enabled = true
  name               = "lambda-access-s3"
  context            = module.this.context

  description = "IAM policy to access the S3 bucket"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "LambdaAccessS3"
    statements = [{
      sid    = "S3ReadAccess"
      effect = "Allow"
      actions = [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ]
      resources = ["arn:aws:s3:::eo-dev-intake/medias/*"]
      }, {
      sid    = "S3WriteAccess"
      effect = "Allow"
      actions = [
        "s3:PutObject",
        "s3:PutObjectAcl"
      ]
      resources = ["arn:aws:s3:::DOC-EXAMPLE-BUCKET/*"]
    }]
  }]
}

module "iam_role" {
  source = "../"

  context = module.this.context

  policy_description = "Allow SSM port forwarding"
  policy_documents = [
    module.policy.json
  ]
  principals = {
    Service = ["ec2.amazonaws.com"]
  }
  role_description = "Example Role"
}

resource "aws_iam_role_policy_attachment" "lambda_logging_policy" {
  role       = module.batch_execution_role.name
  policy_arn = module.lambda_logging_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_access_s3_policy" {
  role       = module.batch_execution_role.name
  policy_arn = module.lambda_access_s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "policy" {
  role       = module.batch_execution_role.name
  policy_arn = module.policy.arn
}


module "batch_execution_role" {
  source = "../"

  name    = "batch-execution"
  context = module.this.context

  role_description = "IAM role that the batch assumes to gain access to required resources."

  principals = {
    Service = ["batch.amazonaws.com"]
  }

  policy_document_count = 0
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"]
}

locals {
  region = data.aws_region.current.name
}

# Variables

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
  default     = "us-west-2"
}

variable "context" {
  type = any
  default = {
    attributes = []
    enabled    = true
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
  default     = "test"
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
  default     = "Iam-Rule"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.
    EOT
}
