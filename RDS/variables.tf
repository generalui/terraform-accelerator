variable "allocated_storage" {
  type        = number
  description = "The allocated storage in GBs. Required unless a `snapshot_identifier` or `replicate_source_db` is provided."
  default     = null
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Allow major version upgrade"
  default     = false
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "The whitelisted CIDRs which to allow `ingress` traffic to the DB instance"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = <<-EOT
    ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,
    in the order they appear in the list. New attributes are appended to the
    end of the list. The elements of the list are joined by the `delimiter`
    and treated as a single ID element.
    EOT
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Allow automated minor version upgrade (e.g. from Postgres 9.5.3 to Postgres 9.5.4)"
  default     = true
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention period in days. Must be > 0 to enable backups"
  default     = 0
}

variable "backup_window" {
  type        = string
  description = "When AWS can perform DB snapshots, can't overlap with maintenance window"
  default     = "22:00-03:00"
}

variable "ca_cert_identifier" {
  type        = string
  description = "The identifier of the CA certificate for the DB instance"
  default     = null
}

variable "context" {
  type = any
  default = {
    attributes = []
    name       = null
    namespace  = null
    stage      = null
    tags       = {}
  }
  description = <<-EOT
    Single object for setting entire context at once.
    See description of individual variables for details.
    Leave string and numeric variables as `null` to use default value.
    Individual variable settings (non-null) override settings in context object,
    except for attributes, tags, and additional_tag_map, which are merged.
  EOT
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy tags from DB to a snapshot"
  default     = true
}

variable "database_name" {
  type        = string
  default     = null
  description = "The name of the database to create when the DB instance is created"
}

variable "database_user" {
  type        = string
  default     = null
  description = "Username for the primary DB user. Required unless a `snapshot_identifier` or `replicate_source_db` is provided."
}

variable "database_password" {
  type        = string
  default     = null
  description = "Password for the primary DB user. Required unless a `snapshot_identifier` or `replicate_source_db` is provided."
}

variable "database_port" {
  type        = number
  description = "Database port (_e.g._ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids`"
}

variable "db_options" {
  type = list(object({
    db_security_group_memberships  = list(string)
    option_name                    = string
    port                           = number
    version                        = string
    vpc_security_group_memberships = list(string)

    option_settings = list(object({
      name  = string
      value = string
    }))
  }))

  default     = []
  description = "A list of DB options to apply with an option group. Depends on DB engine"
}

variable "db_parameter" {
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default     = []
  description = "A list of DB parameters to apply. Note that parameters may differ from a DB family to another"
}

# This is for custom parameters to be passed to the DB
# We're "cloning" default ones, but we need to specify which should be copied
variable "db_parameter_group" {
  type        = string
  description = "The DB parameter group family name. The value depends on DB engine used. See [DBParameterGroupFamily](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBParameterGroup.html#API_CreateDBParameterGroup_RequestParameters) for instructions on how to retrieve applicable value."
  # "mysql5.6"
  # "postgres9.5"
}

variable "db_subnet_group_name" {
  type        = string
  default     = null
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. Specify one of `subnet_ids` or `db_subnet_group_name`"
}

variable "deletion_protection" {
  type        = bool
  description = "Set to true to enable deletion protection on the RDS instance"
  default     = false
}

variable "dns_zone_id" {
  type        = string
  default     = ""
  description = "The ID of the DNS Zone in Route53 where a new DNS record will be created for the DB host name"
}

variable "engine" {
  type        = string
  description = "Database engine type. Required unless a `snapshot_identifier` or `replicate_source_db` is provided."
  default     = null
  # http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  # - mysql
  # - postgres
  # - oracle-*
  # - sqlserver-*
}

variable "engine_version" {
  type        = string
  description = "Database engine version, depends on engine type."
  # http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
}

variable "host_name" {
  type        = string
  default     = "db"
  description = "The DB host name created in Route53"
}

variable "instance_class" {
  type        = string
  description = "Class of RDS instance"
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the existing KMS key to encrypt storage"
  default     = ""
}

variable "major_engine_version" {
  type        = string
  description = "Database MAJOR engine version, depends on engine type"
  default     = ""
  # https://docs.aws.amazon.com/cli/latest/reference/rds/create-option-group.html
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC "
  default     = "Mon:03:00-Mon:04:00"
}

variable "max_allocated_storage" {
  type        = number
  description = "The upper limit to which RDS can automatically scale the storage in GBs"
  default     = 0
}

variable "multi_az" {
  type        = bool
  description = "Set to true if multi AZ deployment must be supported"
  default     = false
}

variable "name" {
  type        = string
  default     = null
  description = <<-EOT
    ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.
    This is the only ID element not also included as a `tag`.
    The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input.
    EOT
}

variable "namespace" {
  type        = string
  default     = null
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "option_group_name" {
  type        = string
  description = "Name of the DB option group to associate"
  default     = ""
}

variable "publicly_accessible" {
  type        = bool
  description = "Determines if database can be publicly available (NOT recommended)"
  default     = false
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "The IDs of the security groups from which to allow `ingress` traffic to the DB instance"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "If true (default), no snapshot will be made before deleting DB"
  default     = true
}

variable "snapshot_identifier" {
  type        = string
  description = "Snapshot identifier e.g: rds:production-2019-06-26-06-05. If specified, the module create cluster from the snapshot"
  default     = null
}

variable "stage" {
  type        = string
  default     = null
  description = "ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'"
}

variable "storage_encrypted" {
  type        = bool
  description = "(Optional) Specifies whether the DB instance is encrypted. The default is false if not specified"
  default     = true
}

variable "storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  default     = "standard"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB. DB instance will be created in the VPC associated with the DB subnet group provisioned using the subnet IDs. Specify one of `subnet_ids` or `db_subnet_group_name`"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC ID the DB instance will be created in"
}

