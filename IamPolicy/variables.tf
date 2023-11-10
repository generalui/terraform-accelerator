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

variable "description" {
  type        = string
  description = "Description of created IAM policy"
  default     = null
}

variable "iam_policy" {
  type = list(object({
    policy_id = optional(string, null)
    version   = optional(string, null)
    statements = list(object({
      sid           = optional(string, null)
      effect        = optional(string, null)
      actions       = optional(list(string), null)
      not_actions   = optional(list(string), null)
      resources     = optional(list(string), null)
      not_resources = optional(list(string), null)
      conditions = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), [])
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), [])
      not_principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), [])
    }))
  }))
  description = <<-EOT
    IAM policy as list of Terraform objects, compatible with Terraform `aws_iam_policy_document` data source
    except that `source_policy_documents` and `override_policy_documents` are not included.
    Use inputs `iam_source_policy_documents` and `iam_override_policy_documents` for that.
    EOT
  default     = []
  nullable    = false
}

variable "iam_policy_enabled" {
  type        = bool
  description = "If set to `true` will create the IAM policy in AWS, otherwise will only output policy as JSON."
  default     = false
}

variable "iam_override_policy_documents" {
  type        = list(string)
  description = <<-EOT
    List of IAM policy documents (as JSON strings) that are merged together into the exported document with higher precedence.
    In merging, statements with non-blank SIDs will override statements with the same SID
    from earlier documents in the list and from other "source" documents.
    EOT
  default     = null
}

variable "iam_source_json_url" {
  type        = string
  description = <<-EOT
    URL of the IAM policy (in JSON format) to download and use as `source_json` argument.
    This is useful when using a 3rd party service that provides their own policy.
    Statements in this policy will be overridden by statements with the same SID in `iam_override_policy_documents`.
    EOT
  default     = null
}

variable "iam_source_policy_documents" {
  type        = list(string)
  description = <<-EOT
    List of IAM policy documents (as JSON strings) that are merged together into the exported document.
    Statements defined in `iam_source_policy_documents` must have unique SIDs and be distinct from SIDs
    in `iam_policy` and deprecated `iam_policy_statements`.
    Statements in these documents will be overridden by statements with the same SID in `iam_override_policy_documents`.
    EOT
  default     = null
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
