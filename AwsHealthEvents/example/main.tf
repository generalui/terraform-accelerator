# This example creates an AWS Virtual Private Cloud (VPC).

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
  source = "git::git@github.com:generalui/terraform-accelerator.git//Label?ref=1.0.1-Label"

  attributes = var.attributes
  name       = var.project
  namespace  = var.namespace
  stage      = var.environment_name

  tags = var.tags

  context = var.context
}

module "health_events" {
  source = "../"

  name    = "health-events"
  context = module.this.context

  event_rules = var.event_rules
  subscribers = {}
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

variable "event_rules" {
  type = list(object({
    name        = string
    description = string
    event_rule_pattern = object({
      detail = object({
        service             = string
        event_type_category = string
        event_type_codes    = list(string)
      })
    })
  }))
  default = [{
    name        = "ec2-scheduled-changes"
    description = "EC2 Health Event — Scheduled Change"
    event_rule_pattern = {
      detail = {
        service             = "EC2"
        event_type_category = "ScheduledChange"
        event_type_codes = [
          "AWS_EC2_DEDICATED_HOST_ACCESSREVOKED_RETIREMENT_SCHEDULED",
          "AWS_EC2_DEDICATED_HOST_NETWORK_MAINTENANCE_SCHEDULED",
          "AWS_EC2_DEDICATED_HOST_POWER_MAINTENANCE_SCHEDULED",
          "AWS_EC2_DEDICATED_HOST_RETIREMENT_SCHEDULED",
          "AWS_EC2_INSTANCE_NETWORK_MAINTENANCE_SCHEDULED",
          "AWS_EC2_INSTANCE_POWER_MAINTENANCE_SCHEDULED",
          "AWS_EC2_INSTANCE_REBOOT_FLEXIBLE_MAINTENANCE_SCHEDULED",
          "AWS_EC2_INSTANCE_REBOOT_MAINTENANCE_SCHEDULED",
          "AWS_EC2_INSTANCE_RETIREMENT_EXPEDITED",
          "AWS_EC2_INSTANCE_RETIREMENT_SCHEDULED",
          "AWS_EC2_INSTANCE_STOP_SCHEDULED",
          "AWS_EC2_INSTANCE_TERMINATION_SCHEDULED",
          "AWS_EC2_PERSISTENT_INSTANCE_POWER_MAINTENANCE_SCHEDULED",
          "AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_EXPEDITED",
          "AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_SCHEDULED",
          "AWS_EC2_SYSTEM_REBOOT_MAINTENANCE_SCHEDULED"
        ]
      }
    }
    }, {
    name        = "ec2-issue",
    description = "EC2 Health Event — Issue",
    event_rule_pattern = {
      detail = {
        service             = "EC2"
        event_type_category = "Issue"
        event_type_codes = [
          "AWS_EC2_NETWORK_CONNECTIVITY_ISSUE",
          "AWS_EC2_INSTANCE_STORE_DRIVE_PERFORMANCE_DEGRADED"
        ]
      }
    }
  }]
  description = "Event Rules"
}

variable "namespace" {
  type        = string
  default     = "xmpl"
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "project" {
  type        = string
  description = "Name of the project as a whole"
  default     = "HealthEvents"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.
    EOT
}
