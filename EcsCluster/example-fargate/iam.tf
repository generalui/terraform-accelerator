module "ecr_access_policy" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamPolicy?ref=1.0.1-IamPolicy"

  iam_policy_enabled = true
  name               = "${module.this.name}-ecr-access"
  context            = module.this.context

  description = "Example IAM policy for accessing the example ECR"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "${replace(title(module.this.name), "/[_-]/", "")}EcrAccess"
    statements = [{
      sid    = "EcrAccess"
      effect = "Allow"
      actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer"
      ]
      resources = [module.ecr.arn]
    }]
  }]
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  role       = module.ecs_cluster.task_role_name
  policy_arn = module.ecr_access_policy.arn
}

module "logging_policy" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamPolicy?ref=1.0.1-IamPolicy"

  iam_policy_enabled = true
  name               = "${module.this.name}-instance-logging"
  context            = module.this.context

  description = "Allows the ECS instance to create logs"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "${replace(title(module.this.name), "/[_-]/", "")}InstanceLogging"
    statements = [{
      sid       = "DescribeLogs"
      effect    = "Allow"
      actions   = ["logs:DescribeLogGroups"],
      resources = ["*"]
      }, {
      sid    = "logging"
      effect = "Allow"
      actions = [
        "ecr:GetDownloadUrlForLayer",
        "logs:CreateLogStream",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
      ]
      resources = ["arn:aws:logs:${var.aws_region}:${local.account_id}:log-group:${local.log_group_name}:*"]
    }]
  }]
}

resource "aws_iam_role_policy_attachment" "logging" {
  role       = module.ecs_cluster.task_role_name
  policy_arn = module.logging_policy.arn
}
