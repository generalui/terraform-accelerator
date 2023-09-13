# variable "alb_security_group" {
#   type        = string
#   description = "Security group of the ALB"
#   default     = ""
# }

# variable "assign_public_ip" {
#   type        = bool
#   description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are `true` or `false`. Default `false`"
#   default     = false
# }

variable "cluster_name" {
  description = "(Required) Name of the cluster (up to 255 letters, numbers, hyphens, and underscores)."
}

variable "cluster_tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
}

# variable "deployment_controller_type" {
#   type        = string
#   description = "Type of deployment controller. Valid values are `CODE_DEPLOY` and `ECS`"
#   default     = "ECS"
# }

# variable "deployment_maximum_percent" {
#   type        = number
#   description = "The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment"
#   default     = 200
# }

# variable "deployment_minimum_healthy_percent" {
#   type        = number
#   description = "The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment"
#   default     = 100
# }

# variable "desired_count" {
#   type        = number
#   description = "The number of instances of the task definition to place and keep running"
#   default     = 1
# }

# variable "ecs_cluster_arn" {
#   type        = string
#   description = "The ARN of the ECS cluster where service will be provisioned"
# }

# variable "health_check_grace_period_seconds" {
#   type        = number
#   description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers"
#   default     = 0
# }

# variable "ignore_changes_task_definition" {
#   type        = bool
#   description = "Whether to ignore changes in container definition and task definition in the ECS service"
#   default     = true
# }

# variable "launch_type" {
#   type        = string
#   description = "The launch type on which to run your service. Valid values are `EC2` and `FARGATE`"
#   default     = "FARGATE"
# }

# variable "network_mode" {
#   type        = string
#   description = "The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` or `null` for `EC2` `launch_type`"
#   default     = "awsvpc"
# }

# variable "propagate_tags" {
#   type        = string
#   description = "Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION"
#   default     = null
# }

# variable "security_group_ids" {
#   description = "Security group IDs to allow in Service `network_configuration` if `var.network_mode = \"awsvpc\"`"
#   type        = list(string)
#   default     = []
# }

# variable "subnet_ids" {
#   type        = list(string)
#   description = "Subnet IDs used in Service `network_configuration` if `var.network_mode = \"awsvpc\"`"
#   default     = null
# }

# variable "tags" {
#   type        = map(string)
#   default     = {}
#   description = <<-EOT
#     Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
#     Neither the tag keys nor the tag values will be modified by this module.
#     EOT
# }

# variable "task_memory" {
#   type        = number
#   description = "The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match [supported cpu value](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
#   default     = 512
# }

# variable "task_cpu" {
#   type        = number
#   description = "The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match [supported memory values](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
#   default     = 256
# }

# variable "vpc_id" {
#   description = "The VPC ID where resources are created"
#   type        = string
# }

# variable "container_port" {
#   type        = number
#   description = "The port on the container to allow traffic from the ALB security group"
#   default     = 80
# }

# ### Container Definition ###

# variable "container_cpu" {
#   type        = number
#   description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
#   default     = 0
# }

# variable "container_environment" {
#   type = list(object({
#     name  = string
#     value = string
#   }))
#   description = "The environment variables to pass to the container. This is a list of maps. map_environment overrides environment"
#   default     = null
# }

# variable "container_essential" {
#   type        = bool
#   description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
#   default     = true
# }

# variable "container_image" {
#   type        = string
#   description = "The image used to start the container. Images in the Docker Hub registry available by default"
# }

# # https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html
# variable "container_log_configuration" {
#   type = object({
#     logDriver = string
#     options   = optional(map(string))
#     secretOptions = optional(list(object({
#       name      = string
#       valueFrom = string
#     })))
#   })
#   description = "Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html"
#   default     = null
# }

# variable "container_memory" {
#   type        = number
#   description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
#   default     = null
# }

# variable "container_memory_reservation" {
#   type        = number
#   description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
#   default     = null
# }

# variable "container_name" {
#   type        = string
#   description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)"
# }

# # https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PortMapping.html
# variable "container_port_mappings" {
#   type = list(object({
#     containerPort = number
#     hostPort      = optional(number)
#     protocol      = optional(string)
#   }))
#   description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"
#   default     = null
# }

# variable "container_readonly_root_filesystem" {
#   type        = bool
#   description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
#   default     = false
# }
