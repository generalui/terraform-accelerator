# This example an ECS cluster with EC2 in a VPC using 2 subnets.
# An ECR is created that holds a generated example Python image that the instance uses.
# An ALB is created to route requests to the container.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.1.0"
}

data "aws_caller_identity" "current" {}
data "aws_ecr_authorization_token" "this" {}

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

provider "docker" {
  registry_auth {
    address  = local.ecr_address
    password = data.aws_ecr_authorization_token.this.password
    username = data.aws_ecr_authorization_token.this.user_name
  }
}

resource "time_static" "activation_date" {}

# This is the "context". It uses the Label module to help ensure consistant naming conventions.
module "this" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//Label?ref=1.0.1-Label"

  attributes = var.attributes
  name       = var.project
  namespace  = var.namespace
  stage      = var.environment_name
  tags       = var.tags

  context = var.context
}
