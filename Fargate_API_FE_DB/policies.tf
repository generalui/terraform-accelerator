resource "aws_iam_role_policy" "cicd_ecr_access_policy" {
  name = "CiCdEcrAccessPolicy"
  role = var.role_name_ci

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ecr:GetAuthorizationToken"
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "ecr:*"
        Effect   = "Allow"
        Resource = aws_ecr_repository.repo.arn
      },
    ]
  })
}

resource "aws_iam_role_policy" "ecs_fargate_deploy_policy" {
  name = "CiCdEcsFargateDeployPolicy"
  role = var.role_name_ci

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecs:UpdateService",
          "ecs:UpdateTaskDefinition",
          "ecs:DescribeServices",
          "ecs:DescribeTaskDefinition",
          "ecs:DescribeTasks",
          "ecs:RegisterTaskDefinition",
          "ecs:ListTasks"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}
