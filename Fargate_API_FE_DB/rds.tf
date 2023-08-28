data "aws_secretsmanager_secret" "db_secrets_by_name" {
  name = var.db_secret_name
}

data "aws_secretsmanager_secret_version" "db_secrets" {
  secret_id = data.aws_secretsmanager_secret.db_secrets_by_name.id
}

resource "aws_db_instance" "default" {
  identifier            = "${var.project}-postgres-${var.environment_name}"
  allocated_storage     = var.db_storage
  max_allocated_storage = var.db_storage_max
  engine                = var.db_engine
  engine_version        = var.db_engine_version
  instance_class        = var.db_instance_class
  name                  = var.db_name
  password              = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)[var.db_secret_pass]
  username              = jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)[var.db_secret_user]
  storage_encrypted     = true

  availability_zone = var.aws_default_zone

  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  skip_final_snapshot       = true
  final_snapshot_identifier = null

  performance_insights_enabled    = var.db_performance_insights_enabled
  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Name = "db"
  }
}
