# This example creates RDS instance.

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

module "vpc" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//VPC?ref=1.0.0"

  name    = "vpc"
  context = module.this.context

  assign_generated_ipv6_cidr_block = false
}

module "db_subnets" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//Subnet?ref=1.0.0"

  name    = "db_subnets"
  context = module.this.context

  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
  igw_id             = [module.vpc.igw_id]
  ipv4_cidr_block    = ["10.0.0.0/24"]
  max_subnet_count   = 2
  vpc_id             = module.vpc.id
}

module "kms_key_db" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//KmsKey?ref=1.0.0"

  context = module.this.context

  alias       = "alias/db-key"
  description = "Key Management Service"
}

module "rds" {
  source = "../"

  context = module.this.context

  allocated_storage       = 20
  backup_retention_period = 31
  database_name           = "nice_db"
  database_user           = "nice_user"
  database_password       = local.db_pass
  database_port           = 5432
  deletion_protection     = true
  db_parameter_group      = "postgres15"
  engine                  = "postgres"
  engine_version          = "15"
  instance_class          = "db.t4g.small"
  kms_key_arn             = module.kms_key_db.key_arn
  max_allocated_storage   = 100
  multi_az                = true
  skip_final_snapshot     = true
  storage_type            = "gp2"

  allowed_cidr_blocks = ["0.0.0.0/0"]
  subnet_ids          = module.db_subnets.private_subnet_ids
  vpc_id              = module.vpc.id
}

# Variables

locals {
  db_pass         = random_password.db_password
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
