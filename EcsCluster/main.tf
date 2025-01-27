resource "aws_ecs_cluster" "default" {
  count = module.this.enabled ? 1 : 0
  name  = module.this.id

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration { cloud_watch_log_group_name = var.log_group_name }
    }
  }

  dynamic "setting" {
    for_each = var.cluster_setting != null ? [1] : []
    content {
      name  = var.cluster_setting.name
      value = var.cluster_setting.value
    }
  }
  tags = merge(module.this.tags, { Name = "${module.this.id}" })
}

module "container_definition" {
  count   = module.this.enabled ? 1 : 0
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.61.1"

  environment = var.container_environment

  container_cpu                = var.container_cpu
  container_definition         = var.container_definition
  container_image              = var.container_image
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  container_name               = var.container_name
  essential                    = var.container_essential
  log_configuration            = var.container_log_configuration
  port_mappings                = var.container_port_mappings
  readonly_root_filesystem     = var.container_readonly_root_filesystem
}

module "ecs_alb_service_task" {
  source  = "cloudposse/ecs-alb-service-task/aws"
  version = "0.74.0"

  context = module.this.context

  alb_security_group                 = var.alb_security_group
  assign_public_ip                   = var.assign_public_ip
  capacity_provider_strategies       = var.capacity_provider_strategies
  container_definition_json          = try(module.container_definition[0].json_map_encoded_list, "")
  container_port                     = var.container_port
  deployment_controller_type         = var.deployment_controller_type
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count                      = var.desired_count
  ecs_cluster_arn                    = try(aws_ecs_cluster.default[0].arn, "")
  ecs_load_balancers                 = var.ecs_load_balancers
  efs_volumes                        = var.efs_volumes
  exec_enabled                       = var.exec_enabled
  force_new_deployment               = var.force_new_deployment
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  ignore_changes_task_definition     = var.ignore_changes_task_definition
  launch_type                        = var.launch_type
  network_mode                       = var.network_mode
  propagate_tags                     = var.propagate_tags
  redeploy_on_apply                  = var.redeploy_on_apply
  security_group_ids                 = var.security_group_ids
  subnet_ids                         = var.subnet_ids
  task_cpu                           = var.task_cpu
  task_definition                    = var.task_definition
  task_exec_role_arn                 = var.task_exec_role_arn
  task_exec_policy_arns              = var.task_exec_policy_arns
  task_exec_policy_arns_map          = var.task_exec_policy_arns_map
  task_memory                        = var.task_memory
  task_policy_arns                   = var.task_policy_arns
  task_policy_arns_map               = var.task_policy_arns_map
  task_role_arn                      = var.task_role_arn
  use_alb_security_group             = var.use_alb_security_group
  vpc_id                             = var.vpc_id
}
