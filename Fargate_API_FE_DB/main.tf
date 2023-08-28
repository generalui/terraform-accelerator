# Based off this recipe: https://dev.to/hlappa/deploying-elixir-phoenix-to-aws-ecs-with-gitlab-ci-and-terraform-4plg
provider "aws" {
  allowed_account_ids = [var.allowed_account_id]
  assume_role {
    role_arn     = var.role_arn
    session_name = var.session_name
    external_id  = var.external_id
  }
  profile = var.aws_profile
  region  = var.aws_region
  default_tags {
    tags = {
        Project     = var.project
        Environment = var.environment_name
    }
  }
}
