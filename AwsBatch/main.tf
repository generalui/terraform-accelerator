# AWS Batch
# Terraform module to create and configure AWS Batch.

data "aws_caller_identity" "current" {}

data "aws_region" "default" {}

resource "aws_batch_compute_environment" "batch_compute_environment" {
  # Ensures the right delete order - AWS-batch-compute environments need these permissions to clean themselves up
  depends_on               = [aws_iam_role_policy_attachment.batch_service_role_policy_attachment]
  compute_environment_name = "${module.this.id}-worker"
  service_role             = aws_iam_role.batch_service_role.arn
  type                     = "MANAGED"

  compute_resources {
    allocation_strategy = var.allocation_strategy
    instance_role       = aws_iam_instance_profile.batch_instance_profile.arn
    instance_type       = var.worker_instance_types
    max_vcpus           = var.worker_max_vcpus
    min_vcpus           = var.worker_min_vcpus
    security_group_ids  = var.worker_security_group_ids
    subnets             = var.worker_subnet_ids
    type                = "EC2"
    dynamic "launch_template" {
      for_each = var.launch_template_id == null && var.launch_template_name == null ? [] : [1]
      content {
        launch_template_id   = var.launch_template_id
        launch_template_name = var.launch_template_name
        version              = var.launch_template_version
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(module.this.tags, { Name = "${module.this.id}-worker" })
}

resource "aws_batch_job_queue" "batch_job_queue" {
  name = "${module.this.id}-worker"

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.batch_compute_environment.arn
  }

  priority = 1
  state    = "ENABLED"
  tags     = merge(module.this.tags, { Name = "${module.this.id}-worker" })
}

resource "aws_batch_job_definition" "batch_job_definition" {
  name = "${module.this.id}-worker"
  type = "container"

  container_properties = jsonencode({
    image       = local.ecr_image_url
    command     = var.command
    environment = local.environment_variables_formatted_for_batch
    # TODO: Determine why this works without this
    # executionRoleArn     = aws_iam_role.batch_execution_role.arn
    linuxParameters      = var.linux_parameters
    mountPoints          = var.container_mount_points
    resourceRequirements = var.resource_requirements
    volumes              = var.container_volumes

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = var.log_group_name
        awslogs-region        = data.aws_region.default.name
        awslogs-stream-prefix = "batch-worker"
      }
    }
  })

  propagate_tags = var.propagate_tags_to_ecs_task
  tags           = merge(module.this.tags, { Name = "${module.this.id}-worker" })
}
