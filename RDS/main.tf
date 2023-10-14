# AWS RDS
# See https://registry.terraform.io/modules/cloudposse/rds/aws/0.43.0

module "rds" {
  source  = "cloudposse/rds/aws"
  version = "0.43.0"

  name      = var.name == null ? var.context.name : var.name
  namespace = var.namespace == null ? var.context.namespace : var.namespace
  stage     = var.stage == null ? var.context.stage : var.stage

  allocated_storage           = var.allocated_storage
  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  backup_retention_period     = var.backup_retention_period
  backup_window               = var.backup_window
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  database_name               = var.database_name
  database_user               = var.database_user
  database_password           = var.database_password
  database_port               = var.database_port
  db_options                  = var.db_options
  db_parameter                = var.db_parameter
  db_parameter_group          = var.db_parameter_group
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  maintenance_window          = var.maintenance_window
  major_engine_version        = var.major_engine_version
  max_allocated_storage       = var.max_allocated_storage
  skip_final_snapshot         = var.skip_final_snapshot
  snapshot_identifier         = var.snapshot_identifier
  storage_type                = va.storage_type
  storage_encrypted           = var.storage_encrypted

  allowed_cidr_blocks = var.allowed_cidr_blocks
  ca_cert_identifier  = var.ca_cert_identifier
  dns_zone_id         = var.dns_zone_id
  host_name           = var.host_name
  multi_az            = var.multi_az
  option_group_name   = var.option_group_name
  publicly_accessible = var.publicly_accessible
  security_group_ids  = var.security_group_ids
  subnet_ids          = var.subnet_ids
  vpc_id              = var.vpc_id
}
