# This example creates an AWS Cognito user pool with a client and two custom attributes

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

# This is the "context". It uses the Label module to help ensure consistant naming conventions.
module "this" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//Label?ref=1.0.0-Label"

  attributes = var.attributes
  name       = var.project
  namespace  = var.namespace
  stage      = var.environment_name

  tags = var.tags

  context = var.context
}

module "cognito" {
  source = "../"

  # deletion_protection = "ACTIVE"

  context = module.this.context


  clients = [{
    generate_secret               = true
    name                          = "${module.this.id}-app-client"
    explicit_auth_flows           = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH"]
    prevent_user_existence_errors = "ENABLED"

    read_attributes = [
      "address",
      "birthdate",
      "custom:custom_attr_02",
      "email",
      "email_verified",
      "family_name",
      "gender",
      "given_name",
      "locale",
      "middle_name",
      "name",
      "nickname",
      "phone_number",
      "phone_number_verified",
      "picture",
      "preferred_username",
      "profile",
      "updated_at",
      "website",
      "zoneinfo"
    ]
  }]

  password_policy = {
    minimum_length                   = 8,
    require_lowercase                = true,
    require_numbers                  = true,
    require_symbols                  = true,
    require_uppercase                = true,
    temporary_password_validity_days = 7
  }

  recovery_mechanisms = [
    {
      name     = "verified_email"
      priority = 1
    },
    {
      name     = "verified_phone_number"
      priority = 2
    }
  ]

  string_schemas = [
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "custom_attr_01"
      // Required custom attributes are not supported currently.
      required = false
      string_attribute_constraints = {
        min_length = 36,
        max_length = 36
      }
      }, {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "custom_attr_02"
      // Required custom attributes are not supported currently.
      required = false
      string_attribute_constraints = {
        min_length = 0,
        max_length = 2048
      }
    }
  ]

  user_groups = [
    {
      description = "Cognito users"
      name        = "${module.this.id}-cognito-user-group"
      precedence  = 1
    }
  ]

  admin_create_user_config_allow_admin_create_user_only = false
  username_attributes                                   = ["email"]
  auto_verified_attributes                              = ["email"]
  region                                                = var.aws_region
  user_group_name                                       = "${module.this.id}-cognito-user-group"
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
  default     = "Cognito"
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

output "identity_pool_id" {
  description = "The ID of the Identity Pool"
  value       = module.cognito.identity_pool_id
}
