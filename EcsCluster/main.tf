resource "aws_ecs_cluster" "default" {
  name = var.cluster_name
  tags = var.cluster_tags
}

# module "ecs-container-definition" {
#   source  = "cloudposse/ecs-container-definition/aws"
#   version = "0.60.0"

#   environment = var.container_environment

#   container_cpu                = var.container_cpu
#   container_image              = var.container_image
#   container_memory             = var.container_memory
#   container_memory_reservation = var.container_memory_reservation
#   container_name               = var.container_name
#   essential                    = var.container_essential
#   log_configuration            = var.container_log_configuration
#   port_mappings                = var.container_port_mappings
#   readonly_root_filesystem     = var.container_readonly_root_filesystem
# }

# module "ecs_alb_service_task" {
#   source  = "cloudposse/ecs-alb-service-task/aws"
#   version = "0.71.0"

#   name      = var.name
#   namespace = var.namespace
#   stage     = var.stage

#   alb_security_group                 = var.alb_security_group
#   assign_public_ip                   = var.assign_public_ip
#   container_definition_json          = module.container_definition.json
#   deployment_controller_type         = var.deployment_controller_type
#   deployment_maximum_percent         = var.deployment_maximum_percent
#   deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
#   desired_count                      = var.desired_count
#   ecs_cluster_arn                    = aws_ecs_cluster.default.arn
#   health_check_grace_period_seconds  = var.health_check_grace_period_seconds
#   ignore_changes_task_definition     = var.ignore_changes_task_definition
#   launch_type                        = var.launch_type
#   network_mode                       = var.network_mode
#   propagate_tags                     = var.propagate_tags
#   security_group_ids                 = var.security_group_ids
#   subnet_ids                         = var.subnet_ids
#   task_memory                        = var.task_memory
#   task_cpu                           = var.task_cpu
#   vpc_id                             = var.vpc_id

#   tags = var.tags
# }
