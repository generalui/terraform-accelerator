# Label context for the example (naming: namespace + project + environment_name).

module "this" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//Label?ref=1.0.1-Label"

  attributes = var.attributes
  enabled    = var.enabled
  name       = var.project
  namespace  = var.namespace
  stage      = var.environment_name
  tags       = var.tags

  context = var.context
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "ID element. Additional attributes to add to the label id."
}

variable "context" {
  type = any
  default = {
    attributes = []
    enabled    = true
    name       = null
    namespace  = null
    stage      = null
    tags       = {}
  }
  description = "Single object for setting entire context at once."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "environment_name" {
  type        = string
  default     = "test"
  description = "Environment name, e.g. prod, staging, dev."
  validation {
    condition     = length(var.environment_name) < 8
    error_message = "environment_name must be less than 8 characters."
  }
}

variable "namespace" {
  type        = string
  default     = "xmpl"
  description = "ID element. Usually an abbreviation of your organization name."
}

variable "project" {
  type        = string
  default     = "dynamodb"
  description = "Project name."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags."
}
