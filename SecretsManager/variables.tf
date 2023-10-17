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

variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Description of the secret."
}

variable "force_overwrite_replica_secret" {
  type        = bool
  default     = true
  description = "Whether to overwrite a secret with the same name in the destination Region."
}

variable "kms_key" {
  type = object({
    enabled                 = optional(bool, true)
    description             = optional(string, "Managed by Terraform")
    alias                   = optional(string)
    deletion_window_in_days = optional(number, 30)
    enable_key_rotation     = optional(bool, true)
  })
  default     = {}
  description = <<-DOC
    enabled:
        Whether to create KSM key.
    description:
        The description of the key as viewed in AWS console.
    alias:
        The display name of the alias. The name must start with the word alias followed by a forward slash.
        If not specified, the alias name will be auto-generated.
    deletion_window_in_days:
        Duration in days after which the key is deleted after destruction of the resource
    enable_key_rotation:
        Specifies whether key rotation is enabled.
  DOC
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = <<-DOC
    ARN or Id of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret.
    If you don't specify this value, then Secrets Manager defaults to using the AWS account's default CMK (the one named `aws/secretsmanager`).
  DOC
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

variable "policy" {
  type        = string
  default     = null
  description = "Valid JSON document representing a resource policy."
}

variable "recovery_window_in_days" {
  type        = number
  default     = 30
  description = "Valid JSON document representing a resource policy."
}

variable "replicas" {
  type = list(
    object(
      {
        kms_key_id = string
        region     = string
      }
    )
  )
  default     = []
  description = <<-DOC
    kms_key_id:
        ARN, Key ID, or Alias of the AWS KMS key within the region secret is replicated to.
    region:
        Region for replicating the secret.
  DOC
}

variable "rotation" {
  type = object({
    enabled                  = optional(bool, false)
    lambda_arn               = string
    automatically_after_days = optional(number, null)
    duration                 = optional(string, null)
    schedule_expression      = optional(string, null)
  })
  default = {
    lambda_arn = ""
  }
  description = <<-DOC
    enabled:
        Whether to create secret rotation rule.
        Default value: `false`
    lambda_arn:
        Specifies the ARN of the Lambda function that can rotate the secret.
    automatically_after_days:
        Specifies the number of days between automatic scheduled rotations of the secret.
    duration:
        The length of the rotation window in hours. For example, `3h` for a three hour window.
    schedule_expression:
        A `cron()` or `rate()` expression that defines the schedule for rotating your secret. Either `automatically_after_days` or `schedule_expression` must be specified.
  DOC
}

variable "secret_version" {
  type = object({
    secret_string          = optional(string, "{}")
    secret_binary          = optional(string)
    ignore_changes_enabled = optional(bool, false)
  })
  sensitive   = true
  default     = {}
  description = <<-DOC
    ignore_changes_enabled:
        Whether to ignore changes in `secret_string` and `secret_binary`.
        Default value: `false`
    secret_string:
        Specifies text data that you want to encrypt and store in this version of the secret.
        This is required if `secret_binary` is not set.
    secret_binary:
        Specifies binary data that you want to encrypt and store in this version of the secret.
        This is required if `secret_string` is not set.
        Needs to be encoded to base64.
  DOC
}

variable "stage" {
  type        = string
  default     = null
  description = "ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.
    EOT
}
