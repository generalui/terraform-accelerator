variable "alb_security_group" {
  type        = string
  description = "Security group of the ALB"
  default     = ""
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are `true` or `false`. Default `false`"
  default     = false
}

variable "capacity_provider_strategies" {
  type = list(object({
    base              = number
    capacity_provider = string
    weight            = number
  }))
  description = "The capacity provider strategies to use for the service. See `capacity_provider_strategy` configuration block: https://www.terraform.io/docs/providers/aws/r/ecs_service.html#capacity_provider_strategy"
  default     = []
}

variable "cluster_setting" {
  type = object({
    name  = optional(string)
    value = optional(string)
  })
  description = "Optional: Cluster settings to apply to the cluster. See: https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html#setting"
  default = {
    name  = null
    value = null
  }

  validation {
    condition     = (var.cluster_setting.name == null && var.cluster_setting.value == null) || var.cluster_setting.name == "containerInsights"
    error_message = "If set, the cluster_setting name must be `containerInsights`."
  }
  validation {
    condition     = (var.cluster_setting.name == null && var.cluster_setting.value == null) || var.cluster_setting.value == "enabled" || var.cluster_setting.value == "disabled"
    error_message = "If set, the cluster_setting value must be enabled or disabled."
  }
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html
variable "container_definition" {
  type = object({
    command = optional(list(string))
    cpu     = optional(number)
    dependsOn = optional(list(object({
      condition     = string
      containerName = string
    })))
    disableNetworking     = optional(bool)
    dnsSearchDomains      = optional(list(string))
    dnsServers            = optional(list(string))
    dockerLabels          = optional(map(string))
    dockerSecurityOptions = optional(list(string))
    entryPoint            = optional(list(string))
    environment = optional(list(object({
      name  = string
      value = string
    })))
    environmentFiles = optional(list(object({
      type  = string
      value = string
    })))
    essential = optional(bool)
    extraHosts = optional(list(object({
      hostname  = string
      ipAddress = string
    })))
    firelensConfiguration = optional(object({
      options = optional(map(string))
      type    = string
    }))
    healthCheck = optional(object({
      command     = list(string)
      interval    = optional(number)
      retries     = optional(number)
      startPeriod = optional(number)
      timeout     = optional(number)
    }))
    hostname    = optional(string)
    image       = optional(string)
    interactive = optional(bool)
    links       = optional(list(string))
    linuxParameters = optional(object({
      capabilities = optional(object({
        add  = optional(list(string))
        drop = optional(list(string))
      }))
      devices = optional(list(object({
        containerPath = string
        hostPath      = string
        permissions   = optional(list(string))
      })))
      initProcessEnabled = optional(bool)
      maxSwap            = optional(number)
      sharedMemorySize   = optional(number)
      swappiness         = optional(number)
      tmpfs = optional(list(object({
        containerPath = string
        mountOptions  = optional(list(string))
        size          = number
      })))
    }))
    logConfiguration = optional(object({
      logDriver = string
      options   = optional(map(string))
      secretOptions = optional(list(object({
        name      = string
        valueFrom = string
      })))
    }))
    memory            = optional(number)
    memoryReservation = optional(number)
    mountPoints = optional(list(object({
      containerPath = optional(string)
      readOnly      = optional(bool)
      sourceVolume  = optional(string)
    })))
    name = optional(string)
    portMappings = optional(list(object({
      containerPort = number
      hostPort      = optional(number)
      protocol      = optional(string)
      name          = optional(string)
      appProtocol   = optional(string)
    })))
    privileged             = optional(bool)
    pseudoTerminal         = optional(bool)
    readonlyRootFilesystem = optional(bool)
    repositoryCredentials = optional(object({
      credentialsParameter = string
    }))
    resourceRequirements = optional(list(object({
      type  = string
      value = string
    })))
    secrets = optional(list(object({
      name      = string
      valueFrom = string
    })))
    startTimeout = optional(number)
    stopTimeout  = optional(number)
    systemControls = optional(list(object({
      namespace = string
      value     = string
    })))
    ulimits = optional(list(object({
      hardLimit = number
      name      = string
      softLimit = number
    })))
    user = optional(string)
    volumesFrom = optional(list(object({
      readOnly        = optional(bool)
      sourceContainer = string
    })))
    workingDirectory = optional(string)
  })
  description = "Container definition overrides which allows for extra keys or overriding existing keys."
  default     = {}
}

variable "container_port" {
  type        = number
  description = "The port on the container to allow traffic from the ALB security group"
  default     = 80
}

variable "deployment_controller_type" {
  type        = string
  description = "Type of deployment controller. Valid values are `CODE_DEPLOY` and `ECS`"
  default     = "ECS"
}

variable "deployment_maximum_percent" {
  type        = number
  description = "The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment"
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment"
  default     = 100
}

variable "desired_count" {
  type        = number
  description = "The number of instances of the task definition to place and keep running"
  default     = 1
}

variable "ecs_load_balancers" {
  type = list(object({
    container_name   = string
    container_port   = number
    elb_name         = optional(string)
    target_group_arn = optional(string)
  }))
  description = "A list of load balancer config objects for the ECS service; see [ecs_service#load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#load_balancer) docs"
  default     = []
}

variable "efs_volumes" {
  type = list(object({
    host_path = string
    name      = string
    efs_volume_configuration = list(object({
      file_system_id          = string
      root_directory          = string
      transit_encryption      = string
      transit_encryption_port = string
      authorization_config = list(object({
        access_point_id = string
        iam             = string
      }))
    }))
  }))

  description = "Task EFS volume definitions as list of configuration objects. You can define multiple EFS volumes on the same task definition, but a single volume can only have one `efs_volume_configuration`."
  default     = []
}

variable "exec_enabled" {
  type        = bool
  description = "Specifies whether to enable Amazon ECS Exec for the tasks within the service"
  default     = false
}

variable "force_new_deployment" {
  type        = bool
  description = "Enable to force a new task deployment of the service."
  default     = false
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers"
  default     = 0
}

variable "ignore_changes_task_definition" {
  type        = bool
  description = "Whether to ignore changes in container definition and task definition in the ECS service"
  default     = true
}

variable "launch_type" {
  type        = string
  description = "The launch type on which to run your service. Valid values are `EC2` and `FARGATE`"
  default     = "FARGATE"
  validation {
    condition     = contains(["EC2", "FARGATE"], var.launch_type)
    error_message = "The launch_type must be either EC2 or FARGATE."
  }
}

variable "log_group_name" {
  type        = string
  description = "The name of the CloudWatch log group to use for logging"
}

variable "network_mode" {
  type        = string
  description = "The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` or `null` for `EC2` `launch_type`"
  default     = "awsvpc"
}

variable "propagate_tags" {
  type        = string
  description = "Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION"
  default     = null
}

variable "redeploy_on_apply" {
  type        = bool
  description = "Updates the service to the latest task definition on each apply"
  default     = false
}

variable "security_group_ids" {
  description = "Security group IDs to allow in Service `network_configuration` if `var.network_mode = \"awsvpc\"`"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs used in Service `network_configuration` if `var.network_mode = \"awsvpc\"`"
  default     = null
}

variable "task_cpu" {
  type        = number
  description = "The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match [supported memory values](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = 256
}

variable "task_definition" {
  type        = list(string)
  description = "A list of zero or one task definition ARNs, to reuse an existing task definition family and revision for the ecs service instead of creating one."
  default     = []
  validation {
    condition     = length(var.task_definition) <= 1
    error_message = "The task_definition must be either empty or contain a single ARN."
  }
}

variable "task_exec_role_arn" {
  type        = any
  description = <<-EOT
    A `list(string)` of zero or one ARNs of IAM roles that allows the
    ECS/Fargate agent to make calls to the ECS API on your behalf.
    If the list is empty, a role will be created for you.
    EOT
  default     = []
}

variable "task_exec_policy_arns" {
  type        = list(string)
  description = <<-EOT
    A list of IAM Policy ARNs to attach to the generated task execution role.
    Changes to the list will have ripple effects, so use `task_exec_policy_arns_map` if possible.
    EOT
  default     = []
}

variable "task_exec_policy_arns_map" {
  type        = map(string)
  description = <<-EOT
    A map of name to IAM Policy ARNs to attach to the generated task execution role.
    The names are arbitrary, but must be known at plan time. The purpose of the name
    is so that changes to one ARN do not cause a ripple effect on the other ARNs.
    If you cannot provide unique names known at plan time, use `task_exec_policy_arns` instead.
    EOT
  default     = {}
}

variable "task_memory" {
  type        = number
  description = "The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match [supported cpu value](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = 512
}

variable "task_policy_arns" {
  type        = list(string)
  description = <<-EOT
    A list of IAM Policy ARNs to attach to the generated task role.
    Changes to the list will have ripple effects, so use `task_policy_arns_map` if possible.
    EOT

  default = []
}

variable "task_policy_arns_map" {
  type        = map(string)
  description = <<-EOT
    A map of name to IAM Policy ARNs to attach to the generated task role.
    The names are arbitrary, but must be known at plan time. The purpose of the name
    is so that changes to one ARN do not cause a ripple effect on the other ARNs.
    If you cannot provide unique names known at plan time, use `task_policy_arns` instead.
    EOT
  default     = {}
}

variable "task_role_arn" {
  type        = list(string)
  description = "A list of zero or one IAM role ARNs that allow the Amazon ECS container task to make calls to other AWS services. If the list is empty, a role will be created."
  default     = []
  validation {
    condition     = length(var.task_role_arn) <= 1
    error_message = "The task_role_arn must be either empty or contain a single ARN."
  }
}

variable "use_alb_security_group" {
  type        = bool
  description = "A flag to enable/disable allowing traffic from the ALB security group to the service security group"
  default     = false
}

variable "vpc_id" {
  description = "The VPC ID where resources are created"
  type        = string
}

### Container Definition ###

variable "container_cpu" {
  type        = number
  description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  default     = 0
}

variable "container_environment" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The environment variables to pass to the container. This is a list of maps. map_environment overrides environment"
  default     = null
}

variable "container_essential" {
  type        = bool
  description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = true
}

variable "container_image" {
  type        = string
  description = "The image used to start the container. Images in the Docker Hub registry available by default"
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html
variable "container_log_configuration" {
  type = object({
    logDriver = string
    options   = optional(map(string))
    secretOptions = optional(list(object({
      name      = string
      valueFrom = string
    })))
  })
  description = "Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html"
  default     = null
}

variable "container_memory" {
  type        = number
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  default     = null
}

variable "container_memory_reservation" {
  type        = number
  description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  default     = null
}

variable "container_name" {
  type        = string
  description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)"
}

# variable "container_port" {
#   type        = number
#   description = "The port on the container to allow traffic from the ALB security group"
#   default     = 80
# }

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PortMapping.html
variable "container_port_mappings" {
  type = list(object({
    containerPort = number
    hostPort      = optional(number)
    protocol      = optional(string)
  }))
  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"
  default     = null
}

variable "container_readonly_root_filesystem" {
  type        = bool
  description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = false
}

### EC2 Specific ###

variable "autoscaling_force_delete" {
  type        = bool
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "autoscaling_managed_draining" {
  type        = string
  description = "Enables or disables a graceful shutdown of instances without disturbing workloads. Valid values are ENABLED and DISABLED."
  default     = "ENABLED"
  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.autoscaling_managed_draining)
    error_message = "The autoscaling_managed_draining value must be either ENABLED or DISABLED."
  }
}

variable "autoscaling_managed_termination_protection" {
  type        = string
  description = "Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens. Valid values are ENABLED and DISABLED."
  default     = "ENABLED"
  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.autoscaling_managed_termination_protection)
    error_message = "The autoscaling_managed_termination_protection value must be either ENABLED or DISABLED."
  }
}

variable "autoscaling_max_size" {
  type        = number
  description = "The maximum number of instances to scale to"
  default     = 1
}

variable "autoscaling_min_size" {
  type        = number
  description = "The minimum number of instances to scale to"
  default     = 1
}

variable "autoscaling_protect_from_scale_in" {
  type        = bool
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events"
  default     = false
}

variable "appautoscaling_target_max_capacity" {
  type        = number
  description = "The maximum value to scale to in response to a scale in event"
  default     = 1
}

variable "appautoscaling_target_min_capacity" {
  type        = number
  description = "The minimum value to scale to in response to a scale out event"
  default     = 1
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of instance to start"
  default     = "t3.small"
}

variable "launch_template_update_default_version" {
  type        = bool
  description = "Whether to update the default version of the launch template when replacing or updating the template"
  default     = true
}

variable "managed_scaling_instance_warmup_period" {
  type        = number
  description = "The period of time, in seconds, after a newly launched Amazon EC2 instance can contribute to CloudWatch metrics for Auto Scaling group. This delay lets an instance finish initializing before producing metrics"
  default     = 300
}

variable "managed_scaling_maximum_scaling_step_size" {
  type        = number
  description = "The maximum step adjustment size. A number between 1-10000"
  default     = 1000
  validation {
    condition     = var.managed_scaling_maximum_scaling_step_size >= 1 && var.managed_scaling_maximum_scaling_step_size <= 10000
    error_message = "The managed_scaling_maximum_scaling_step_size value must be between 1 and 10000."
  }
}

variable "managed_scaling_minimum_scaling_step_size" {
  type        = number
  description = "The minimum step adjustment size. A number between 1-10000"
  default     = 1
  validation {
    condition     = var.managed_scaling_minimum_scaling_step_size >= 1 && var.managed_scaling_minimum_scaling_step_size <= 10000
    error_message = "The managed_scaling_minimum_scaling_step_size value must be between 1 and 10000."
  }
}

variable "managed_scaling_target_max_capacity" {
  type        = number
  description = "Target utilization for the capacity provider. A number between 1 and 100."
  default     = 1
  validation {
    condition     = var.managed_scaling_target_max_capacity >= 1 && var.managed_scaling_target_max_capacity <= 100
    error_message = "The managed_scaling_target_max_capacity value must be between 1 and 100."
  }
}
