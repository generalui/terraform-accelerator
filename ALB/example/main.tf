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

module "vpc" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//VPC?ref=1.0.1-VPC"

  name    = "alb-vpc"
  context = module.this.context

  assign_generated_ipv6_cidr_block = false
}

module "subnet" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//Subnet?ref=1.0.1-Subnet"

  name    = "alb-subnet"
  context = module.this.context

  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
  igw_id             = [module.vpc.igw_id]
  ipv4_cidr_block    = [module.vpc.cidr_block]
  max_subnet_count   = 2
  vpc_id             = module.vpc.id
}

module "alb" {
  source = "../"

  name    = "alb"
  context = module.this.context

  alb_access_logs_s3_bucket_force_destroy = true
  deletion_protection_enabled             = false
  security_group_ids                      = [module.vpc.default_security_group_id]
  subnet_ids                              = module.subnet.public_subnet_ids
  vpc_id                                  = module.vpc.id

  stickiness = {
    cookie_duration = 600
    enabled         = true
  }
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
  default     = "ALB"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.
    EOT
}
