#########################################
# General
#########################################
variable "batch_failed_alarm_actions" {
  type        = list(string)
  default     = []
  description = "List of SNS topic ARNs to notify on failure."
}

variable "command" {
  type        = list(string)
  default     = ["python", "app.py"]
  description = "Command to run on the container."
}

variable "container_mount_points" {
  type = list(object({
    containerPath = optional(string)
    readOnly      = optional(bool)
    sourceVolume  = optional(string)
  }))
  default     = []
  description = "Optional: List of container mount points. This parameter maps to Volumes in the Create a container section of the Docker Remote API (https://docs.docker.com/engine/api/v1.43/#tag/Container/operation/ContainerCreate) and the --volume option to docker run."
}

variable "container_volumes" {
  type = list(object({
    efsVolumeConfiguration = optional(object({
      authorizationConfig = optional(object({
        accessPointId = optional(string)
        iam           = optional(string)
      }))
      fileSystemId          = string
      rootDirectory         = optional(string)
      transitEncryption     = optional(string)
      transitEncryptionPort = optional(number)
    }))
    host = optional(object({
      sourcePath = optional(string)
    }))
    name = optional(string)
  }))
  default     = []
  description = "Optional: List of of data volumes used in a job. See https://docs.aws.amazon.com/batch/latest/APIReference/API_Volume.html for details."
}

variable "log_group_name" {
  type        = string
  description = "String to prefix AWS resource names. This will also be used for the event log group but will be prepended with /aws/events/."
}

variable "log_retention_in_days" {
  type        = number
  default     = 30
  description = "Number of days to retain batch event logs for. Default: 30"
}

variable "propagate_tags_to_ecs_task" {
  type        = bool
  default     = true
  description = "Optional: Whether to propagate tags from the job definition to the ECS task or not. Defaults to true."
}

variable "worker_environment_variables" {
  type = map(string)
  default = {
  }
  description = "Optional: Specify optional environment variables to pass to the worker."
}

variable "resource_requirements" {
  default = [{
    type = "VCPU", value = "1"
    }, {
    type = "MEMORY", value = "512"
  }]
  description = "The type and amount of a resource to assign to a container. The supported resources include GPU, MEMORY, and VCPU. See: https://docs.aws.amazon.com/batch/latest/APIReference/API_ResourceRequirement.html"
  type        = list(object({ type = string, value = string }))
  validation {
    condition = length(var.resource_requirements) == 0 || alltrue([
      for req in var.resource_requirements : contains(["GPU", "MEMORY", "VCPU"], req.type)
    ])
    error_message = "The resource_requirements type must be one of GPU, MEMORY or VCPU."
  }
}

#########################################
# COMPUTE ENVIRONMENT
#########################################
variable "allocation_strategy" {
  type        = string
  default     = "BEST_FIT"
  description = "The allocation strategy to use for the compute resource in case not enough instances of the best fitting instance type can be allocated. This might be because of availability of the instance type in the region or Amazon EC2 service limits. For more information, see https://docs.aws.amazon.com/batch/latest/APIReference/API_ComputeResource.html#Batch-Type-ComputeResource-allocationStrategy"
  validation {
    condition     = contains(["BEST_FIT", "BEST_FIT_PROGRESSIVE", "SPOT_CAPACITY_OPTIMIZED", "SPOT_PRICE_CAPACITY_OPTIMIZED"], var.allocation_strategy)
    error_message = "The allocation_strategy must be one of BEST_FIT, BEST_FIT_PROGRESSIVE, SPOT_CAPACITY_OPTIMIZED or SPOT_PRICE_CAPACITY_OPTIMIZED."
  }
}

variable "launch_template_id" {
  type        = string
  description = "The ID of the launch template. You must specify either the launch template ID or launch template name in the request, but not both."
  default     = null
}

variable "launch_template_name" {
  type        = string
  description = "Name of the launch template. You must specify either the launch template ID or launch template name in the request, but not both."
  default     = null
}

variable "launch_template_version" {
  type        = string
  description = "The version number of the launch template. Default: The default version of the launch template."
  default     = null
}

variable "linux_parameters" {
  type = object({
    devices = optional(list(object({
      hostPath      = string
      containerPath = optional(string)
      permissions   = optional(list(string))
    }))),
    initProcessEnabled = optional(bool)
    maxSwap            = optional(number)
    sharedMemorySize   = optional(number)
    swappiness         = optional(number)
    tmpfs = optional(list(object({
      containerPath = string
      mountOptions  = optional(list(string))
      size          = number
    })))
  })
  default     = null
  description = "Linux-specific modifications that are applied to the container, such as details for device mappings."
}

variable "worker_instance_types" {
  type        = set(string)
  default     = ["m4.large"]
  description = "Optional: List of one or more valid EC2 instance types to use. example: ['m4.large']"
}

variable "worker_max_vcpus" {
  type        = number
  default     = 16
  description = "Optional: Max number of vcpus to run at the same time. Example: 16"
}

variable "worker_min_vcpus" {
  type        = number
  default     = 0
  description = "Optional: Min number of vcpus to run at the same time. If 0, then there will be no EC2 instancse while idle. If > 0, then there will always be at least one hot instance ready to take jobs. Example: 0"
}

#########################################
# VPC
#########################################
variable "worker_security_group_ids" {
  type        = set(string)
  default     = []
  description = "Optional: example: [module.db_security_group.id]"
}

variable "worker_subnet_ids" {
  type        = set(string)
  default     = []
  description = "Optional: example: module.db_subnets.private_subnet_ids"
}

#########################################
# ECR - used by Lambda OR AWS-Batch
#########################################
variable "ecr_tag" {
  type        = string
  description = "Optional: The version tag for the of the lambda ECR image to use. If not provided, be sure to set the lambda_runtime instead."
}

variable "ecr_url" {
  type        = string
  description = "Optional: Url for the ecr repository for the lambda ECR image. If not provided, be sure to set the lambda_runtime instead."
}
