# App Runner example: ECR repo, Docker image build/push, App Runner service.
# Run from this directory: terraform init && terraform apply

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
      Environment = var.environment_name
      Maintained  = "terraform"
      Project     = var.project
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

module "apprunner" {
  depends_on = [module.ecr]
  source     = "../"

  context = module.this.context

  image_identifier      = docker_registry_image.this.name
  image_repository_type = "ECR"
  port                  = "5000"

  ecr_repository_arn = module.ecr.arn
}
