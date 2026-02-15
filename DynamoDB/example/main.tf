# DynamoDB example: single table with hash key (on-demand, encrypted, PITR).
# Run from this directory: terraform init && terraform apply

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.3"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment_name
      Maintained  = "terraform"
      Project     = var.project
    }
  }
}

module "dynamodb" {
  source = "../"

  context = module.this.context

  attribute = [
    { name = "id", type = "S" }
  ]
  key_schema = [
    { name = "id", key_type = "HASH" }
  ]
}
