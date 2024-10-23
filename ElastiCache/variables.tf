variable "additional_security_group_rules" {
  type        = list(any)
  default     = []
  description = <<-EOT
    A list of Security Group rule objects to add to the created security group, in addition to the ones
    this module normally creates. (To suppress the module's rules, set `create_security_group` to false
    and supply your own security group via `associated_security_group_ids`.)
    The keys and values of the objects are fully compatible with the `aws_security_group_rule` resource, except
    for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique and known at "plan" time.
    To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule .
    EOT
}

variable "alarm_actions" {
  type        = list(string)
  description = "Alarm action list. ** Not available for Serverless."
  default     = []
}

variable "alarm_cpu_threshold_percent" {
  type        = number
  default     = 75
  description = "CPU threshold alarm level. ** Not available for Serverless."
}

variable "alarm_memory_threshold_bytes" {
  # 10MB
  type        = number
  default     = 10000000
  description = "Ram threshold alarm level. ** Not available for Serverless."
}

variable "allow_all_egress" {
  type        = bool
  default     = null
  description = <<-EOT
    If `true`, the created security group will allow egress on all ports and protocols to all IP address.
    If this is false and no egress rules are otherwise specified, then no egress will be allowed.
    Defaults to `true` unless the deprecated `egress_cidr_blocks` is provided and is not `["0.0.0.0/0"]`, in which case defaults to `false`.
    EOT
}

variable "allowed_security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of IDs of Security Groups to allow access to the security group created by this module."
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Apply changes immediately. ** Not available for Serverless."
}

variable "associated_security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of IDs of Security Groups to associate the created resource with, in addition to the created security group. These security groups will not be modified and, if `create_security_group` is `false`, must provide all the required access."
}

variable "at_rest_encryption_enabled" {
  type        = bool
  default     = false
  description = "Enable encryption at rest."
}

variable "auth_token" {
  type        = string
  description = "Auth token for password protecting redis, `transit_encryption_enabled` must be set to `true`. Password must be longer than 16 chars. ** Not available for Serverless."
  default     = null
  sensitive   = true
  validation {
    condition     = var.auth_token == null || length(coalesce(var.auth_token, 0)) > 16
    error_message = "Auth token must be longer than 16 chars."
  }
}

variable "auth_token_update_strategy" {
  type        = string
  description = "Strategy to use when updating the auth_token. Valid values are `SET`, `ROTATE`, or `DELETE`. Defaults to `ROTATE`. ** Not available for Serverless."
  default     = "ROTATE"
  validation {
    condition     = contains(["SET", "ROTATE", "DELETE"], var.auth_token_update_strategy)
    error_message = "Valid values for auth_token_update_strategy are `SET`, `ROTATE`, or `DELETE`."
  }
}

variable "auto_minor_version_upgrade" {
  type        = bool
  default     = null
  description = "Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported if the engine version is 6 or higher. ** Not available for Serverless."
}

variable "automatic_failover_enabled" {
  type        = bool
  default     = false
  description = "Automatic failover (Not available for T1/T2 instances). ** Not available for Serverless."
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zone IDs. ** Not available for Serverless."
  default     = []
}

variable "cloudwatch_metric_alarms_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable CloudWatch metrics alarms. ** Not available for Serverless."
  default     = false
}

variable "cluster_mode_enabled" {
  type        = bool
  description = "Flag to enable/disable creation of a native redis cluster. `automatic_failover_enabled` must be set to `true`. Only 1 `cluster_mode` block is allowed."
  default     = false
}

variable "cluster_mode_num_node_groups" {
  type        = number
  description = "Number of node groups (shards) for this Redis replication group. Changing this number will trigger an online resizing operation before other settings modifications. ** Not available for Serverless."
  default     = 0
}

variable "cluster_mode_replicas_per_node_group" {
  type        = number
  description = "Number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will force a new resource. ** Not available for Serverless."
  default     = 0
  validation {
    condition     = var.cluster_mode_replicas_per_node_group >= 0 && var.cluster_mode_replicas_per_node_group <= 5
    error_message = "Valid values for cluster_mode_replicas_per_node_group are 0 to 5."
  }
}

variable "cluster_size" {
  type        = number
  default     = 1
  description = "Number of nodes in cluster. *Ignored when `cluster_mode_enabled` == `true`* ** Not available for Serverless."
}

variable "create_parameter_group" {
  type        = bool
  default     = true
  description = "Whether new parameter group should be created. Set to false if you want to use existing parameter group."
}

variable "create_security_group" {
  type        = bool
  default     = true
  description = "Set `true` to create and configure a new security group. If false, `associated_security_group_ids` must be provided."
}

variable "data_tiering_enabled" {
  type        = bool
  default     = false
  description = "Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type. ** Not available for Serverless."
}

variable "description" {
  type        = string
  default     = null
  description = "Description of elasticache replication group."
}

variable "dns_subdomain" {
  type        = string
  default     = ""
  description = "The subdomain to use for the CNAME record. If not provided then the CNAME record will use var.name."
}

variable "elasticache_subnet_group_name" {
  type        = string
  description = "Subnet group name for the ElastiCache instance. ** Not available for Serverless."
  default     = ""
}

variable "engine_version" {
  type        = string
  default     = "7.1"
  description = "Redis engine version. ** Not available for Serverless - see `serverless_major_engine_version`"
}

variable "family" {
  type        = string
  default     = "redis7"
  description = "Redis family"
}

variable "final_snapshot_identifier" {
  type        = string
  description = "The name of your final node group (shard) snapshot. ElastiCache creates the snapshot from the primary node in the cluster. If omitted, no final snapshot will be made. ** Not available for Serverless."
  default     = null
}

variable "inline_rules_enabled" {
  type        = bool
  description = <<-EOT
    NOT RECOMMENDED. Create rules "inline" instead of as separate `aws_security_group_rule` resources.
    See [#20046](https://github.com/hashicorp/terraform-provider-aws/issues/20046) for one of several issues with inline rules.
    See [this post](https://github.com/hashicorp/terraform-provider-aws/pull/9032#issuecomment-639545250) for details on the difference between inline rules and rule resources.
    EOT
  default     = false
}

variable "instance_type" {
  type        = string
  default     = "cache.t2.micro"
  description = "Elastic cache instance type. ** Not available for Serverless."
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. `at_rest_encryption_enabled` must be set to `true`."
  default     = null
  sensitive   = true
}

variable "log_delivery_configuration" {
  type = list(object({
    destination      = string
    destination_type = string
    log_format       = string
    log_type         = string
  }))
  default     = []
  description = "The log_delivery_configuration block allows the streaming of Redis SLOWLOG or Redis Engine Log to CloudWatch Logs or Kinesis Data Firehose. Max of 2 blocks. ** Not available for Serverless."
  validation {
    condition     = length(var.log_delivery_configuration) <= 2
    error_message = "Max of 2 blocks allowed."
  }
  validation {
    condition     = alltrue([for config in var.log_delivery_configuration : contains(["cloudwatch-logs", "kinesis-firehose"], config.destination_type)])
    error_message = "Valid values for destination_type are 'cloudwatch-logs' or 'kinesis-firehose'"
  }
  validation {
    condition     = alltrue([for config in var.log_delivery_configuration : contains(["json", "text"], config.log_format)])
    error_message = "Valid values for log_format are 'json' or 'text'"
  }
  validation {
    condition     = alltrue([for config in var.log_delivery_configuration : contains(["engine-log", "slow-log"], config.log_type)])
    error_message = "Valid values for log_type are 'engine-log' or 'slow-log'"
  }


}

variable "maintenance_window" {
  type        = string
  default     = "wed:03:00-wed:04:00"
  description = "Maintenance window. ** Not available for Serverless."
}

variable "multi_az_enabled" {
  type        = bool
  default     = false
  description = "Multi AZ (Automatic Failover must also be enabled. If Cluster Mode is enabled, Multi AZ is on by default, and this setting is ignored). ** Not available for Serverless."
}

variable "notification_topic_arn" {
  type        = string
  default     = ""
  description = "Notification topic arn. ** Not available for Serverless."
}

variable "ok_actions" {
  type        = list(string)
  description = "The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN). ** Not available for Serverless."
  default     = []
}

variable "parameter" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "A list of Redis parameters to apply. Note that parameters may differ from one Redis family to another."
}

variable "parameter_group_description" {
  type        = string
  default     = null
  description = "Description of parameter group."
}

variable "parameter_group_name" {
  type        = string
  default     = null
  description = "Override the default parameter group name."
}

variable "port" {
  type        = number
  default     = 6379
  description = "Redis port. This is always 6379 for Serverless Redis."
}

variable "preserve_security_group_id" {
  type        = bool
  description = <<-EOT
    When `false` and `create_before_destroy` is `true`, changes to security group rules
    cause a new security group to be created with the new rules, and the existing security group is then
    replaced with the new one, eliminating any service interruption.
    When `true` or when changing the value (from `false` to `true` or from `true` to `false`),
    existing security group rules will be deleted before new ones are created, resulting in a service interruption,
    but preserving the security group itself.
    **NOTE:** Setting this to `true` does not guarantee the security group will never be replaced,
    it only keeps changes to the security group rules from triggering a replacement.
    See the README for further discussion.
    EOT
  default     = false
}

variable "replication_group_id" {
  type        = string
  description = "Replication group ID with the following constraints: \nA name must contain from 1 to 20 alphanumeric characters or hyphens. \n The first character must be a letter. \n A name cannot end with a hyphen or contain two consecutive hyphens."
  default     = ""
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = <<-EOT
    Instruct Terraform to revoke all of the Security Group's attached ingress and egress rules before deleting
    the security group itself. This is normally not needed.
    EOT
  default     = false
}

variable "security_group_create_before_destroy" {
  type        = bool
  default     = true
  description = <<-EOT
    Set `true` to enable Terraform `create_before_destroy` behavior on the created security group.
    We only recommend setting this `false` if you are upgrading this module and need to keep
    the existing security group from being replaced.
    Note that changing this value will always cause the security group to be replaced.
    EOT
}

variable "security_group_create_timeout" {
  type        = string
  default     = "10m"
  description = "How long to wait for the security group to be created."
}

variable "security_group_delete_timeout" {
  type        = string
  default     = "15m"
  description = "How long to retry on `DependencyViolation` errors during security group deletion."
}

variable "security_group_description" {
  type        = string
  default     = "Security group for Elasticache Redis"
  description = <<-EOT
    The description to assign to the created Security Group.
    Warning: Changing the description causes the security group to be replaced.
    EOT
}

variable "security_group_name" {
  type        = list(string)
  description = "The name to assign to the security group. Must be unique within the VPC. If not provided, will be derived from the `null-label.context` passed in. If `create_before_destroy` is true, will be used as a name prefix."
  default     = []
  validation {
    condition     = length(var.security_group_name) < 2
    error_message = "Only 1 security group name can be provided."
  }
}

variable "serverless_cache_usage_limits" {
  type = object({
    data_storage = optional(object({
      maximum = number
      minimum = number
      unit    = string
    }))
    ecpu_per_second = optional(object({
      maximum = number
      minimum = number
    }))
  })
  default     = {}
  description = "The usage limits for the serverless cache."
  validation {
    condition     = length(coalesce(var.serverless_cache_usage_limits, {})) > 0 ? (length(coalesce(var.serverless_cache_usage_limits.data_storage, {})) > 1 ? var.serverless_cache_usage_limits.data_storage == null || var.serverless_cache_usage_limits.data_storage.maximum >= var.serverless_cache_usage_limits.data_storage.minimum && var.serverless_cache_usage_limits.data_storage.maximum >= 1 && var.serverless_cache_usage_limits.data_storage.maximum <= 5000 : true) : true
    error_message = "data_storage.maximum must be between 1 and 5000 and must be greater than or equal to data_storage.minimum"
  }
  validation {
    condition     = length(coalesce(var.serverless_cache_usage_limits, {})) > 0 ? (length(coalesce(var.serverless_cache_usage_limits.data_storage, {})) > 1 ? var.serverless_cache_usage_limits.data_storage.minimum >= 1 && var.serverless_cache_usage_limits.data_storage.minimum <= 5000 : true) : true
    error_message = "data_storage.minimum must be between 1 and 5000"
  }
  validation {
    condition     = length(coalesce(var.serverless_cache_usage_limits, {})) > 0 ? (length(coalesce(var.serverless_cache_usage_limits.data_storage, {})) > 1 ? var.serverless_cache_usage_limits.data_storage.unit == "GB" : true) : true
    error_message = "data_storage.unit must be GB"
  }
  validation {
    condition     = length(coalesce(var.serverless_cache_usage_limits, {})) > 0 ? (length(coalesce(var.serverless_cache_usage_limits.ecpu_per_second, {})) > 1 ? var.serverless_cache_usage_limits.ecpu_per_second.maximum >= var.serverless_cache_usage_limits.ecpu_per_second.minimum && var.serverless_cache_usage_limits.ecpu_per_second.maximum >= 1000 && var.serverless_cache_usage_limits.ecpu_per_second.maximum <= 15000000 : true) : true
    error_message = "ecpu_per_second.maximum must be between 1000 and 15000000 and must be greater than or equal to ecpu_per_second.minimum"
  }
  validation {
    condition     = length(coalesce(var.serverless_cache_usage_limits, {})) > 0 ? (length(coalesce(var.serverless_cache_usage_limits.ecpu_per_second, {})) > 1 ? var.serverless_cache_usage_limits.ecpu_per_second.minimum >= 1000 && var.serverless_cache_usage_limits.ecpu_per_second.minimum <= 15000000 : true) : true
    error_message = "ecpu_per_second.minimum must be between 1000 and 15000000"
  }
}

# Add boolean to create a serverless cluster
variable "serverless_enabled" {
  type        = bool
  default     = false
  description = "Flag to enable/disable creation of a serverless redis cluster"
}

variable "serverless_major_engine_version" {
  type        = string
  default     = "7"
  description = "The major version of the engine to use for the serverless cluster"
}

variable "serverless_snapshot_time" {
  type        = string
  default     = "06:00"
  description = "The daily time that snapshots will be created from the serverless cache."
}

variable "serverless_user_group_id" {
  type        = string
  default     = null
  description = "User Group ID to associate with the replication group"
}

variable "snapshot_arns" {
  type        = list(string)
  description = "A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb ** Not available for Serverless."
  default     = []
  validation {
    condition     = length(var.snapshot_arns) <= 1
    error_message = "Only one snapshot_arn can be specified."
  }
}

variable "snapshot_name" {
  type        = string
  description = "The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource. ** Not available for Serverless."
  default     = null
}

variable "snapshot_retention_limit" {
  type        = number
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them."
  default     = 0
}

variable "snapshot_window" {
  type        = string
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. ** Not available for Serverless."
  default     = "06:30-07:30"
}

variable "subnets" {
  type        = list(string)
  description = "Subnet IDs."
  default     = []
}

variable "target_security_group_id" {
  type        = list(string)
  description = <<-EOT
    The ID of an existing Security Group to which Security Group rules will be assigned.
    The Security Group's name and description will not be changed.
    Not compatible with `inline_rules_enabled` or `revoke_rules_on_delete`.
    If not provided (the default), this module will create a security group.
    EOT
  default     = []
  validation {
    condition     = length(var.target_security_group_id) < 2
    error_message = "Only 1 security group can be targeted."
  }
}

variable "transit_encryption_enabled" {
  type        = bool
  default     = true
  description = <<-EOT
    Set `true` to enable encryption in transit. Forced `true` if `var.auth_token` is set.
    If this is enabled, use the [following guide](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/in-transit-encryption.html#connect-tls) to access redis.
    ** Not available for Serverless."
    EOT
}

variable "transit_encryption_mode" {
  type        = string
  default     = null
  description = <<-EOT
    A setting that enables clients to migrate to in-transit encryption with no downtime. Valid values are `preferred` and `required`. When enabling encryption on an existing replication group, this must first be set to `preferred` before setting it to `required` in a subsequent apply. See the TransitEncryptionMode field in the [CreateReplicationGroup](https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_CreateReplicationGroup.html) API documentation for additional details."
    ** Not available for Serverless."
    EOT
  validation {
    condition     = var.transit_encryption_mode == null || contains(["preferred", "required"], coalesce(var.transit_encryption_mode, "invalid"))
    error_message = "Valid values for transit_encryption_mode are `preferred` and `required`."
  }
}

variable "user_group_ids" {
  type        = list(string)
  default     = null
  description = "User Group ID to associate with the replication group. ** Not available for Serverless."
}

variable "zone_id" {
  type        = list(string)
  default     = []
  description = "Route53 DNS Zone ID as list of string (0 or 1 items). If empty, no custom DNS name will be published. If the list contains a single Zone ID, a custom DNS name will be pulished in that zone."
  validation {
    condition     = length(var.zone_id) <= 1
    error_message = "The zone_id variable must contain 0 or 1 items."
  }
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}
