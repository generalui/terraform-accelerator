# App Runner module — service from ECR/ECR Public image, optional VPC connector and custom domain.
# Modeled after terraform-accelerator modules: Label + optional IamRole, then App Runner resources.

# Optional: VPC connector (when vpc_connector_arn not provided and subnets are set)
resource "aws_apprunner_vpc_connector" "this" {
  count = local.create_vpc_connector ? 1 : 0

  vpc_connector_name = "${module.this.id}-vpc"
  subnets            = var.vpc_connector_subnet_ids
  security_groups    = var.vpc_connector_security_group_ids != null ? var.vpc_connector_security_group_ids : []

  tags = module.this.tags
}

# App Runner service
resource "aws_apprunner_service" "this" {
  count = module.this.enabled ? 1 : 0

  service_name = module.this.id

  source_configuration {
    dynamic "authentication_configuration" {
      for_each = local.resolved_access_role_arn != null ? [1] : []
      content {
        access_role_arn = local.resolved_access_role_arn
      }
    }
    image_repository {
      image_identifier      = var.image_identifier
      image_repository_type = var.image_repository_type
      image_configuration {
        port = var.port
      }
    }
    auto_deployments_enabled = var.auto_deployments_enabled
  }

  instance_configuration {
    cpu               = var.cpu
    memory            = var.memory
    instance_role_arn = var.instance_role_arn
  }

  health_check_configuration {
    path     = var.health_check_path
    protocol = var.health_check_protocol
  }

  dynamic "network_configuration" {
    for_each = local.use_vpc_connector && local.vpc_connector_arn != null ? [1] : []
    content {
      egress_configuration {
        egress_type       = "VPC"
        vpc_connector_arn = local.vpc_connector_arn
      }
    }
  }

  tags = module.this.tags
}

# Optional: custom domain association
resource "aws_apprunner_custom_domain_association" "this" {
  count = module.this.enabled && var.custom_domain_name != null && var.custom_domain_name != "" ? 1 : 0

  service_arn = aws_apprunner_service.this[0].arn
  domain_name = var.custom_domain_name
}
