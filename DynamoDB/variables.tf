###
# DynamoDB - Table schema
###

variable "attribute" {
  type = list(object({
    name = string
    type = string
  }))
  description = <<-EOT
    List of attribute definitions. Each element must have `name` and `type` (S, N, or B).
    Must include an attribute for every key in `key_schema`.
    EOT
  validation {
    condition     = length(var.attribute) > 0
    error_message = "attribute must have at least one element (the hash key)."
  }
}

variable "key_schema" {
  type = list(object({
    name     = string
    key_type = string
  }))
  description = <<-EOT
    List of key schema elements. Each element must have `name` (attribute name) and `key_type` (HASH or RANGE).
    Exactly one HASH key is required; RANGE key is optional.
    EOT
  validation {
    condition     = length([for k in var.key_schema : k if k.key_type == "HASH"]) == 1
    error_message = "key_schema must contain exactly one element with key_type = \"HASH\"."
  }
}

###
# DynamoDB - Billing & capacity
###

variable "billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "Billing mode: PAY_PER_REQUEST (on-demand) or PROVISIONED."
  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing_mode)
    error_message = "billing_mode must be PAY_PER_REQUEST or PROVISIONED."
  }
}

variable "read_capacity" {
  type        = number
  default     = null
  description = "Number of read capacity units. Required when billing_mode is PROVISIONED."
}

variable "write_capacity" {
  type        = number
  default     = null
  description = "Number of write capacity units. Required when billing_mode is PROVISIONED."
}

###
# DynamoDB - Encryption & recovery (HIPAA-aligned defaults)
###

variable "server_side_encryption_enabled" {
  type        = bool
  default     = true
  description = "Enable server-side encryption at rest (AWS managed key unless kms_key_arn is set)."
}

variable "kms_key_arn" {
  type        = string
  default     = null
  description = "ARN of a KMS key for server-side encryption. When null, AWS owned key is used (default)."
}

variable "point_in_time_recovery_enabled" {
  type        = bool
  default     = true
  description = "Enable point-in-time recovery (continuous backups). Recommended for production and compliance."
}

###
# DynamoDB - Streams & TTL (optional)
###

variable "stream_enabled" {
  type        = bool
  default     = false
  description = "Enable DynamoDB Streams for change data capture."
}

variable "stream_view_type" {
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
  description = "Stream view type when stream_enabled is true: KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  validation {
    condition     = contains(["KEYS_ONLY", "NEW_IMAGE", "OLD_IMAGE", "NEW_AND_OLD_IMAGES"], var.stream_view_type)
    error_message = "stream_view_type must be one of KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  }
}

variable "ttl_attribute_name" {
  type        = string
  default     = null
  description = "Name of the attribute to use for TTL. When set, TTL is enabled on the table."
}

variable "ttl_enabled" {
  type        = bool
  default     = null
  description = "Enable TTL. Defaults to true when ttl_attribute_name is non-null, else false."
}
