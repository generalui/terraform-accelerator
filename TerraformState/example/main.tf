# This example creates terraform state in an S3 bucket with a lock in DynamoDB.

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
  region = var.aws_region
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment_name
    }
  }
}

# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# README.md
# THIS EXAMPLE DOES NOT WORK! NEEDS A REAL role_arn.
module "state_backend" {
  source = "../"

  attributes = ["state"]
  enabled    = true
  context    = module.this.context

  force_destroy                      = true
  profile                            = var.aws_profile
  terraform_backend_config_file_path = ""
  terraform_state_file               = "${var.namespace}-${var.project}.terraform.tfstate"
}

# Variables

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
