# This example creates a Security Group.

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

module "vpc" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//VPC?ref=1.0.1-VPC"

  name    = "vpc"
  context = module.this.context

  assign_generated_ipv6_cidr_block = false
}

module "security_group_example_1" {
  source = "../"

  # Security Group names must be unique within a VPC.
  # This module follows Cloud Posse naming conventions and generates the name
  # based on the inputs to the null-label module, which means you cannot
  # reuse the label as-is for more than one security group in the VPC.

  enabled = true
  context = module.this.context
  name    = "security-group-example-1"

  description = "An example security group"

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["https-443-tcp"]

  ingress_with_self = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Container to VPC endpoint service"
      self        = true
    },
  ]

  vpc_id = module.vpc.id
}

module "security_group_example_2" {
  source = "../"

  # Security Group names must be unique within a VPC.
  # This module follows Cloud Posse naming conventions and generates the name
  # based on the inputs to the null-label module, which means you cannot
  # reuse the label as-is for more than one security group in the VPC.

  enabled = true
  context = module.this.context
  name    = "security-group-example-2"

  description = "An example security group"

  egress_with_cidr_blocks = [
    {
      name        = "Resource egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "Egress from resource"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      name        = "Resource ingress"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "Ingress to resource"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  vpc_id = module.vpc.id
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
  default     = "example"
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
