terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # Configurations for the backend are in a separate file (ie. config.dev.tfbackend)
  # Use `terraform init -backend-config=config.dev.tfbackend`
  backend "s3" {
    key          = "tfstates/terraform.tfstate"
  }
}
