# This example creates a private S3 bucket by users in the created "s3_access" group and then by assuming the created "s3-access" role.

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

data "aws_caller_identity" "current" {}

# Generate a random string to append to the end of the secret's name.
# Secrets aren't immediatelt deleted. If this needs to be deleted and recreated,
# Each instance of the secrate should have a nunique name.
resource "random_string" "secret_name" {
  length  = 6
  special = false
}

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

resource "aws_iam_group" "s3_access" {
  name = "${module.this.id}-s3_access"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "s3_access" {
  group      = aws_iam_group.s3_access.name
  policy_arn = module.assume_s3_access.arn
}

module "assume_s3_access" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamPolicy?ref=1.0.1-IamPolicy"

  name    = "${module.this.id}-assume-s3-access"
  context = module.this.context

  description = "Allows assuming the s3_access Role"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "AssumeS3Access"
    statements = [
      {
        sid       = "AssumeRole"
        effect    = "Allow"
        actions   = ["sts:AssumeRole"]
        resources = [module.role.arn]
      }
    ]
  }]
  iam_policy_enabled = true
}

module "s3_access_policy" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamPolicy?ref=1.0.1-IamPolicy"

  name    = "${module.this.id}-s3-access-policy"
  context = module.this.context

  description = "Allows accessing the S3 bucket"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "S3Access"
    statements = [{
      sid       = "ReadBucket"
      effect    = "Allow"
      actions   = ["s3:GetObject", "s3:ListBucket", "s3:GetBucketLocation"]
      resources = [module.s3_bucket.arn]
    }]
  }]
}

module "role" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamRole?ref=1.0.1-IamRole"

  name    = "${module.this.id}-s3-access"
  context = module.this.context

  policy_description = "Allow Access to the S3 Bucket"
  role_description   = "Allow Access to the S3 Bucket"

  principals = {
    AWS = ["arn:aws:iam::${local.account_id}:root"]
  }

  policy_documents = [
    module.s3_access_policy.json
  ]
}

module "s3_bucket" {
  source = "../"

  name    = "exampleBucket"
  context = module.this.context

  s3_object_ownership = "BucketOwnerEnforced"
  user_enabled        = false
  versioning_enabled  = false

  privileged_principal_arns = [{
    "${module.role.arn}" = ["prefix1/", "prefix2/"]
  }]
  privileged_principal_actions = [
    "s3:PutObject",
    "s3:PutObjectAcl",
    "s3:GetObject",
    "s3:DeleteObject",
    "s3:ListBucket",
    "s3:ListBucketMultipartUploads",
    "s3:GetBucketLocation",
    "s3:AbortMultipartUpload"
  ]
}

# Outputs

output "arn" {
  value       = module.s3_bucket.arn
  description = "Bucket ARN"
}

output "id" {
  value       = module.s3_bucket.id
  description = "Bucket Name (aka ID)"
}

output "principal_arn" {
  value       = module.role.arn
  description = "The ARN of the Role that has access to the S3 bucket."
}

# Variables

locals {
  account_id      = data.aws_caller_identity.current.account_id
  key_secret_name = "${module.this.context.name}-key-${random_string.secret_name.result}"
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
  default     = "example"
  validation {
    condition     = length(var.environment_name) < 8
    error_message = "The environment_name value must be less than 8 characters"
  }
}

variable "namespace" {
  type        = string
  default     = "S3"
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "project" {
  type        = string
  description = "Name of the project as a whole"
  default     = "XmplPrjct"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.
    EOT
}
