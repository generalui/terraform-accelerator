# A Terraform module for creating a cross-account-accessible ECR repository.
# See https://registry.terraform.io/modules/terraform-aws-modules/ecr/aws/1.6.0

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"

  repository_name                   = var.name
  repository_read_write_access_arns = var.allowed_arns

  tags = var.tags
}

# module "ecr" {
#   source = "cloudposse/ecr/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   # version     = "x.x.x"
#   namespace              = "eg"
#   stage                  = "test"
#   name                   = "ecr"
#   principals_full_access = [data.aws_iam_role.ecr.arn]
# }
