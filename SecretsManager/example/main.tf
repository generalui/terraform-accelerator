# This example creates database secrets and stores them in the AWS Secrets Manager.

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

resource "random_password" "db_password" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!_"
}

# Generate a random string to append to the end of the secret's name.
# Secrets aren't immediatelt deleted. If this needs to be deleted and recreated,
# Each instance of the secrate should have a nunique name.
resource "random_string" "secret_name" {
  length  = 6
  special = false
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

module "kms_key" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//KmsKey?ref=1.0.0"

  context = module.this.context

  alias       = "alias/db-key"
  description = "Key Management Service"
}

module "db_secrets" {
  source = "../"

  context = module.this.context
  name    = local.db_secret_name

  # Don't use the built in KMS, use the `kms_key` module.
  kms_key = {
    enabled = false
  }
  kms_key_id = module.kms_key.key_id
  secret_version = {
    secret_string = jsonencode(
      {
        dbname   = var.db_name
        engine   = "postgres"
        host     = ""
        password = local.db_pass
        port     = 5432
        username = var.db_user
      }
    )
  }
}

# Variables

locals {
  db_pass        = random_password.db_password.result
  db_secret_name = "${module.this.context.name}-db-${random_string.secret_name.result}"
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

variable "db_name" {
  type        = string
  default     = "test_db"
  description = "Name of the db"
}

variable "db_user" {
  type        = string
  default     = "primary_db_user"
  description = "Username for the primary DB user."
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
