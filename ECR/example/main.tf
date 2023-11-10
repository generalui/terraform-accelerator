# This example creates an ECR that is only accessible by the two created roles (read & write).

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

module "write_iam_role" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//IamRole?ref=1.0.0"

  name    = "example-ecr-write-access-role"
  context = module.this.context

  role_description      = "Example ECR Write Access Role"
  policy_document_count = 0
  principals = {
    AWS = ["arn:aws:iam::${local.account_id}:root"]
  }
  use_fullname = false
}

module "read_iam_role" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//IamRole?ref=1.0.0"

  name    = "example-ecr-read-access-role"
  context = module.this.context

  role_description      = "Example ECR Read Access Role"
  policy_document_count = 0
  principals = {
    AWS = ["arn:aws:iam::${local.account_id}:root"]
  }
  use_fullname = false
}

module "ecr" {
  source = "../"

  name    = "example-ecr"
  context = module.this.context

  principals_readonly_access = [module.read_iam_role.arn, module.write_iam_role.arn]
}

# Variables

locals {
  account_id = data.aws_caller_identity.current.account_id
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
  default     = "dev"
  validation {
    condition     = length(var.environment_name) < 8
    error_message = "The environment_name value must be less than 8 characters"
  }
}

variable "namespace" {
  type        = string
  default     = "test"
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

# Outputs

output "arn_map" {
  value       = module.ecr.arn_map
  description = "Map of repository names to repository ARNs"
}

output "url" {
  value       = module.ecr.url
  description = "URL of first repository created"
}
