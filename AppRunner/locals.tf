locals {
  # Access role: create when ECR and no access_role_arn (count must not depend on ecr_repository_arn so plan works when ecr_repository_arn = module.ecr.arn)
  create_access_role = module.this.enabled && var.image_repository_type == "ECR" && var.access_role_arn == null
  # VPC: use provided connector ARN or create one when subnets (and optionally SGs) are provided
  create_vpc_connector = module.this.enabled && var.vpc_connector_arn == null && var.vpc_connector_subnet_ids != null && length(var.vpc_connector_subnet_ids) > 0
  use_vpc_connector    = module.this.enabled && (var.vpc_connector_arn != null || local.create_vpc_connector)
  vpc_connector_arn    = var.vpc_connector_arn != null ? var.vpc_connector_arn : (local.create_vpc_connector ? aws_apprunner_vpc_connector.this[0].arn : null)
  # Resolved access role for private ECR
  resolved_access_role_arn = local.create_access_role ? module.apprunner_access_role[0].arn : var.access_role_arn
}
