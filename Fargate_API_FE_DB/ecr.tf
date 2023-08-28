resource "aws_ecr_repository" "repo" {
  name = jsondecode(data.aws_secretsmanager_secret_version.ci_secrets.secret_string)[var.ci_ecr_repo_name]

  tags = {
    Name = "repo"
  }
}
