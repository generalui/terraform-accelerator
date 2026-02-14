###
# App Runner - Image source
###

variable "image_identifier" {
  type        = string
  description = "Full image identifier (e.g. ECR URL or ECR Public URL). For ECR: `account.dkr.ecr.region.amazonaws.com/repo:tag`. For ECR Public: `public.ecr.aws/.../image:tag`."
}

variable "image_repository_type" {
  type        = string
  description = "Type of the image repository. Valid values: `ECR`, `ECR_PUBLIC`."
  default     = "ECR"
  validation {
    condition     = contains(["ECR", "ECR_PUBLIC"], var.image_repository_type)
    error_message = "image_repository_type must be ECR or ECR_PUBLIC."
  }
}

variable "port" {
  type        = string
  description = "Port that your application listens to in the container."
  default     = "8080"
}

variable "runtime_environment_variables" {
  type        = map(string)
  description = "Environment variables for the running service (key-value). Non-sensitive only; for secrets use runtime_environment_secrets."
  default     = {}
}

variable "runtime_environment_secrets" {
  type        = map(string)
  description = "Secrets for the running service: map of env var name to Secrets Manager secret ARN or SSM Parameter Store parameter ARN."
  default     = {}
}

###
# App Runner - Access role (for private ECR)
###

variable "access_role_arn" {
  type        = string
  default     = null
  description = "ARN of IAM role for App Runner to pull the image from ECR. Required for private ECR when not creating a role. When null and ecr_repository_arn is set, the module creates a role."
}

variable "ecr_repository_arn" {
  type        = string
  default     = null
  description = "ARN of the ECR repository. Used only when access_role_arn is null to create an access role with least-privilege ECR pull for this repository."
}

###
# App Runner - Instance & scaling
###

variable "cpu" {
  type        = string
  description = "Number of CPU units for each instance. Valid values: 256, 512, 1024, 2048, 4096 (or 0.25, 0.5, 1, 2, 4 vCPU)."
  default     = "1024"
}

variable "memory" {
  type        = string
  description = "Memory reserved for each instance (e.g. 512, 1024, 2048, 3072, 4096, 6144, 8192, 10240, 12288 MB, or 0.5, 1, 2, 3, 4, 6, 8, 10, 12 GB)."
  default     = "2048"
}

variable "instance_role_arn" {
  type        = string
  default     = null
  description = "Optional ARN of IAM role for the running service (permissions your code needs when calling AWS APIs)."
}

variable "auto_deployments_enabled" {
  type        = bool
  description = "Whether automatic deployments from the source repository are enabled (e.g. new image tag)."
  default     = false
}

###
# App Runner - VPC connector (optional)
###

variable "vpc_connector_subnet_ids" {
  type        = list(string)
  default     = null
  description = "List of subnet IDs for the VPC connector. When set, a VPC connector is created and the service egress is set to VPC."
}

variable "vpc_connector_security_group_ids" {
  type        = list(string)
  default     = null
  description = "List of security group IDs for the VPC connector. Required when vpc_connector_subnet_ids is set."
}

variable "vpc_connector_arn" {
  type        = string
  default     = null
  description = "ARN of an existing App Runner VPC connector. If set, used instead of creating one (vpc_connector_subnet_ids and vpc_connector_security_group_ids are ignored)."
}

###
# App Runner - Custom domain (optional)
###

variable "custom_domain_name" {
  type        = string
  default     = null
  description = "Custom domain name to associate with the App Runner service (e.g. app.example.com)."
}

variable "certificate_arn" {
  type        = string
  default     = null
  description = "ARN of ACM certificate for the custom domain. Required when custom_domain_name is set if the certificate is not in us-east-1 (App Runner uses us-east-1 for cert validation in some cases)."
}

###
# Health check (optional overrides)
###

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "URL path for HTTP health checks."
}

variable "health_check_protocol" {
  type        = string
  default     = "HTTP"
  description = "Protocol for health checks. Valid values: TCP, HTTP."
}
