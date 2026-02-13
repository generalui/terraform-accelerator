# Optional: IAM role for App Runner to pull from ECR (when access_role_arn not provided)
# Trust: build.apprunner.amazonaws.com; policy: ECR GetAuthorizationToken + pull for the given repo
module "apprunner_access_role" {
  count = local.create_access_role ? 1 : 0

  source = "git::git@github.com:generalui/terraform-accelerator.git//IamRole?ref=1.0.1-IamRole"

  context = module.this.context
  name    = "${module.this.name}-ecr-access"

  role_description      = "Allows App Runner to pull container images from ECR."
  principals            = { Service = ["build.apprunner.amazonaws.com"] }
  policy_document_count = 0
  policy_name           = "${module.this.name}-ecr-pull"

  tags = merge(module.this.tags, { Name = "${module.this.id}-ecr-access" })
}

module "ecr_access_policy" {
  count = local.create_access_role ? 1 : 0

  source = "git::git@github.com:ohgod-ai/eo-terraform.git//IamPolicy?ref=1.0.1-IamPolicy"

  iam_policy_enabled = true
  name               = "ecr-access"
  context            = module.this.context

  description = "IAM policy for accessing the ECR"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "EcrAccess"
    statements = [{
      sid       = "GetAuthorizationToken"
      effect    = "Allow"
      actions   = ["ecr:GetAuthorizationToken"]
      resources = ["*"]
      }, {
      sid    = "PullImage"
      effect = "Allow"
      actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer"
      ]
      resources = [var.ecr_repository_arn]
    }]
  }]
}

# Only create when the module creates the role (when access_role_arn is null).
resource "aws_iam_role_policy_attachment" "ecr_access_attach" {
  count = local.create_access_role ? 1 : 0

  role       = module.apprunner_access_role[0].name
  policy_arn = module.ecr_access_policy[0].arn
}
