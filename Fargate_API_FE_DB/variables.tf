variable "allowed_account_id" {
  type        = string
  description = "The allowed AWS account ID to prevent you from mistakenly using an incorrect one (and potentially end up destroying a live environment)."
}

variable "ami" {
  type        = string
  description = "The AMI to use for the EC2 instance."
  default     = "ami-0c7ea5497c02abcaf" # Debian Buster x86_64 ebs hmv AMI
}

variable "aws_default_zone" {
  type        = string
  description = "The AWS region where the resources will be created."
  default     = ""
}

variable "aws_profile" {
  type        = string
  description = "The AWS profile name as set in the shared credentials file."
  default     = "default"
}

variable "aws_region" {
  type        = string
  description = "The AWS region."
  default     = "us-west-2"
}

variable "cert_arn_api" {
  type        = string
  description = "The ARN of the certificate for the domain."
}

variable "cert_arn_fe" {
  type        = string
  description = "The ARN of the certificate for the front end domain."
}

variable "ci_ecr_repo_name" {
  type        = string
  description = "The key name of the Elastic Container Repository name value."
}

variable "ci_secret_name" {
  type        = string
  description = "The name of the CI secrets."
}

variable "db_performance_insights_enabled" {
  type        = bool
  description = "Enable in depth tracing of queries and performance statistics."
  default     = false
}

variable "db_engine" {
  type        = string
  description = "The type of database."
  default     = "postgres"
}

variable "db_engine_version" {
  type        = string
  description = "The version of postgres for the database."
  default     = "12.5"
}

variable "db_instance_class" {
  type        = string
  description = "The database instance class."
  default     = "db.t2.medium"
}

variable "db_name" {
  type        = string
  description = "Name of the db"
}

variable "db_secret_name" {
  type        = string
  description = "The name of the Database secrets."
}

variable "db_secret_pass" {
  type        = string
  description = "The key name of the Database password value."
}

variable "db_secret_user" {
  type        = string
  description = "The key name of the Database username value."
}

variable "db_storage" {
  type        = number
  description = "The amount of database storage. This is the starting point for the storage. It will scale to `db_storage_max` as needed."
  default     = 10
}

variable "db_storage_max" {
  type        = number
  description = "The maximum amount of database storage. The database storage will scale up to this if needed."
  default     = 20
}

variable "domain_api" {
  type        = string
  description = "The domain name for the api."
}

variable "domain_fe" {
  type        = string
  description = "The domain name for the front end."
}

variable "ec2_key" {
  type        = string
  description = "The key pair to allow SSH access to the EC2."
}

variable "ecs_application_count" {
  type        = number
  description = "Container count of the application"
  default     = 1
}

variable "ecs_fargate_application_cpu" {
  type        = string
  description = "CPU units"
}

variable "ecs_fargate_application_mem" {
  type        = string
  description = "Memory value"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Should the VPC enable DNS hostnames"
  default     = false
}

variable "enable_dns_support" {
  type        = bool
  description = "Should the VPC enable DNS support"
  default     = false
}

variable "environment_name" {
  type        = string
  description = "Current environment"
  default     = "development"
}

variable "external_id" {
  type        = string
  description = "The extrnal id to pass with AWS credentials."
}

variable "external_id_ci" {
  type        = string
  description = "The extrnal id the CI role needs to pass with AWS credentials."
}

variable "instance_type" {
  type        = string
  description = "The type of instance to use for the EC2 instance."
  default     = "t3a.medium" # 2 vCPUS,	x86_64,	4 GiB RAM, Up to 5 Gigabit, $0.0376/hour
}

variable "name_api" {
  type        = string
  description = "Name of the API application"
  default     = "API"
}

variable "name_fe" {
  type        = string
  description = "Name of the front end application"
  default     = "Front End"
}

variable "project" {
  type        = string
  description = "Name of the project as a whole"
  default     = "Project"
}

variable "role_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the IAM Role to assume."
}

variable "role_name_ci" {
  type        = string
  description = "The Name of the IAM Role for CICD."
}

variable "session_name" {
  type        = string
  description = "Session name to use when assuming the AWS role"
  default     = "aws-session"
}

variable "zone_id" {
  type        = string
  description = "The ID of the Hosted Zone of the api domain"
}

variable "zone_id_fe" {
  type        = string
  description = "The ID of the Hosted Zone of the front end domain"
}
