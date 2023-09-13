#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "Name prefix for resources on AWS"

  validation {
    condition     = length(var.name_prefix) < 8
    error_message = "The name_prefix value must be less than 8 characters"
  }
}

#------------------------------------------------------------------------------
# AWS Networking
#------------------------------------------------------------------------------
variable "vpc_id" {
  description = "ID of the VPC"
}

#------------------------------------------------------------------------------
# AWS ECS SERVICE
#------------------------------------------------------------------------------
variable "ecs_cluster_arn" {
  description = "ARN of an ECS cluster"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
}

variable "task_definition_arn" {
  description = "(Required) The full ARN of the task definition that you want to run in your service."
}

#------------------------------------------------------------------------------
# AWS ECS SERVICE network_configuration BLOCK
#------------------------------------------------------------------------------
variable "public_subnets" {
  description = "The public subnets associated with the task or service."
  type        = list(any)
}

variable "private_subnets" {
  description = "The private subnets associated with the task or service."
  type        = list(any)
}

#------------------------------------------------------------------------------
# AWS ECS SERVICE load_balancer BLOCK
#------------------------------------------------------------------------------
variable "container_name" {
  description = "Name of the running container"
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER
#------------------------------------------------------------------------------
variable "lb_internal" {
  description = "(Optional) If true, the LB will be internal."
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Target Groups
#------------------------------------------------------------------------------
variable "ssl_policy" {
  description = "(Optional) The name of the SSL Policy for the listener. . Required if var.https_ports is set."
  type        = string
  default     = null
}

variable "default_certificate_arn" {
  description = "(Optional) The ARN of the default SSL server certificate. Required if var.https_ports is set."
  type        = string
  default     = null
}

variable "additional_certificates_arn_for_https_listeners" {
  description = "(Optional) List of SSL server certificate ARNs for HTTPS listener. Use it if you need to set additional certificates besides default_certificate_arn"
  type        = list(any)
  default     = []
}
