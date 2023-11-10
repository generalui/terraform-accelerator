variable "assume_role_actions" {
  type        = list(string)
  default     = ["sts:AssumeRole", "sts:TagSession"]
  description = "The IAM action to be granted by the AssumeRole policy"
}

variable "assume_role_conditions" {
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  description = "List of conditions for the assume role policy"
  default     = []
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

variable "instance_profile_enabled" {
  type        = bool
  default     = false
  description = "Create EC2 Instance Profile for the role"
}

variable "managed_policy_arns" {
  type        = set(string)
  description = "List of managed policies to attach to created role"
  default     = []
}

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours"
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

variable "path" {
  type        = string
  description = "Path to the role and policy. See [IAM Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) for more information."
  default     = "/"
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "ARN of the policy that is used to set the permissions boundary for the role"
}

variable "policy_description" {
  type        = string
  default     = ""
  description = "The description of the IAM policy that is visible in the IAM policy manager"
}

variable "policy_documents" {
  type        = list(string)
  description = "List of JSON IAM policy documents"
  default     = []
}

variable "policy_document_count" {
  type        = number
  description = "Number of policy documents (length of policy_documents list)"
  default     = 1
}

variable "policy_name" {
  type        = string
  description = "The name of the IAM policy that is visible in the IAM policy manager"
  default     = null
}

variable "principals" {
  type        = map(list(string))
  description = "Map of service name as key and a list of ARNs to allow assuming the role as value (e.g. map(`AWS`, list(`arn:aws:iam:::role/admin`)))"
  default     = {}
}

variable "role_description" {
  type        = string
  description = "The description of the IAM role that is visible in the IAM role manager"
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

variable "tags_enabled" {
  type        = string
  description = "Enable/disable tags on IAM roles and policies"
  default     = true
}

variable "use_fullname" {
  type        = bool
  default     = true
  description = <<-EOT
  If set to 'true' then the full ID for the IAM role name (e.g. `[var.namespace]-[var.environment]-[var.stage]`) will be used.

  Otherwise, `var.name` will be used for the IAM role name.
  EOT
}


