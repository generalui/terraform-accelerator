output "exec_role_policy_id" {
  description = "The ECS service role policy ID, in the form of `role_name:role_policy_name`"
  value       = try(module.ecs_alb_service_task.ecs_exec_role_policy_id, null)
}

output "exec_role_policy_name" {
  description = "ECS service role name"
  value       = try(module.ecs_alb_service_task.ecs_exec_role_policy_name, null)
}

output "service_name" {
  description = "ECS Service name"
  value       = try(module.ecs_alb_service_task.service_name, null)
}

output "service_arn" {
  description = "ECS Service ARN"
  value       = try(module.ecs_alb_service_task.service_arn, null)
}

output "service_role_arn" {
  description = "ECS Service role ARN"
  value       = try(module.ecs_alb_service_task.service_role_arn, null)
}

output "task_exec_role_name" {
  description = "ECS Task role name"
  value       = try(module.ecs_alb_service_task.task_exec_role_name, null)
}

output "task_exec_role_arn" {
  description = "ECS Task exec role ARN"
  value       = try(module.ecs_alb_service_task.task_exec_role_arn, null)
}

output "task_exec_role_id" {
  description = "ECS Task exec role id"
  value       = try(module.ecs_alb_service_task.task_exec_role_id, null)
}

output "task_role_name" {
  description = "ECS Task role name"
  value       = try(module.ecs_alb_service_task.task_role_name, null)
}

output "task_role_arn" {
  description = "ECS Task role ARN"
  value       = try(module.ecs_alb_service_task.task_role_arn, null)
}

output "task_role_id" {
  description = "ECS Task role id"
  value       = try(module.ecs_alb_service_task.task_role_id, null)
}

output "service_security_group_id" {
  description = "Security Group ID of the ECS task"
  value       = try(module.ecs_alb_service_task.service_security_group_id, null)
}

output "task_definition_family" {
  description = "ECS task definition family"
  value       = try(module.ecs_alb_service_task.task_definition_family, null)
}

output "task_definition_revision" {
  description = "ECS task definition revision"
  value       = try(module.ecs_alb_service_task.task_definition_revision, null)
}

output "task_definition_arn" {
  description = "ECS task definition ARN"
  value       = try(module.ecs_alb_service_task.task_definition_arn, null)
}

output "task_definition_arn_without_revision" {
  description = "ECS task definition ARN without revision"
  value       = try(module.ecs_alb_service_task.task_definition_arn_without_revision, null)
}

#------------------------------------------------------------------------------
# ECS CLUSTER
#------------------------------------------------------------------------------
output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) that identifies the cluster"
  value       = try(aws_ecs_cluster.default[0].arn, null)
}

output "cluster_id" {
  description = "The Amazon ID that identifies the cluster"
  value       = try(aws_ecs_cluster.default[0].id, null)
}

output "cluster_name" {
  description = "The Name of the cluster"
  value       = try(aws_ecs_cluster.default[0].name, null)
}

output "cluster_tags" {
  description = "The name of the cluster"
  value       = try(aws_ecs_cluster.default[0].tags_all, null)
}
