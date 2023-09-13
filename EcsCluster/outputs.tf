# output "exec_role_policy_id" {
#   description = "The ECS service role policy ID, in the form of `role_name:role_policy_name`"
#   value       = module.ecs_alb_service_task.ecs_exec_role_policy_id
# }

# output "exec_role_policy_name" {
#   description = "ECS service role name"
#   value       = module.ecs_alb_service_task.ecs_exec_role_policy_name
# }

# output "service_name" {
#   description = "ECS Service name"
#   value       = module.ecs_alb_service_task.service_name
# }

# output "service_arn" {
#   description = "ECS Service ARN"
#   value       = module.ecs_alb_service_task.service_arn
# }

# output "service_role_arn" {
#   description = "ECS Service role ARN"
#   value       = module.ecs_alb_service_task.service_role_arn
# }

# output "task_exec_role_name" {
#   description = "ECS Task role name"
#   value       = module.ecs_alb_service_task.task_exec_role_name
# }

# output "task_exec_role_arn" {
#   description = "ECS Task exec role ARN"
#   value       = module.ecs_alb_service_task.task_exec_role_arn
# }

# output "task_exec_role_id" {
#   description = "ECS Task exec role id"
#   value       = module.ecs_alb_service_task.task_exec_role_id
# }

# output "task_role_name" {
#   description = "ECS Task role name"
#   value       = module.ecs_alb_service_task.task_role_name
# }

# output "task_role_arn" {
#   description = "ECS Task role ARN"
#   value       = module.ecs_alb_service_task.task_role_arn
# }

# output "task_role_id" {
#   description = "ECS Task role id"
#   value       = module.ecs_alb_service_task.task_role_id
# }

# output "service_security_group_id" {
#   description = "Security Group ID of the ECS task"
#   value       = module.ecs_alb_service_task.service_security_group_id
# }

# output "task_definition_family" {
#   description = "ECS task definition family"
#   value       = module.ecs_alb_service_task.task_definition_family
# }

# output "task_definition_revision" {
#   description = "ECS task definition revision"
#   value       = module.ecs_alb_service_task.task_definition_revision
# }

# output "task_definition_arn" {
#   description = "ECS task definition ARN"
#   value       = module.ecs_alb_service_task.task_definition_arn
# }

#------------------------------------------------------------------------------
# ECS CLUSTER
#------------------------------------------------------------------------------
output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) that identifies the cluster"
  value       = aws_ecs_cluster.default.arn
}

output "cluster_id" {
  description = "The Amazon ID that identifies the cluster"
  value       = aws_ecs_cluster.default.id
}

output "cluster_tags" {
  description = "The name of the cluster"
  value       = aws_ecs_cluster.default.tags_all
}
