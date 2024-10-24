variable "allowed_security_groups" {
  type        = list(string)
  default     = []
  description = "List of existing Security Groups to be allowed to connect to the DocumentDB cluster"
}

variable "cluster_size" {
  type        = number
  default     = 3
  description = "Number of DB instances to create in the cluster"
}

# https://docs.aws.amazon.com/documentdb/latest/developerguide/limits.html#suported-instance-types
variable "instance_class" {
  type        = string
  default     = "db.r4.large"
  description = "The instance class to use. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-instance-classes.html#db-instance-class-specs"
}

variable "master_password" {
  type        = string
  default     = ""
  description = "(Required unless a snapshot_identifier is provided) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Please refer to the DocumentDB Naming Constraints"
}

variable "master_username" {
  type        = string
  default     = "admin1"
  description = "(Required unless a snapshot_identifier is provided) Username for the master DB user"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of VPC subnet IDs to place DocumentDB instances in"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to create the cluster in (e.g. `vpc-a22222ee`)"
}

variable "zone_id" {
  type        = string
  default     = ""
  description = "Route53 parent zone ID. If provided (not empty), the module will create sub-domain DNS records for the DocumentDB master and replicas"
}
