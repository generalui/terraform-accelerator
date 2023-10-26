

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

variable "dns_name" {
  type        = string
  description = "The name of the DNS record"
  default     = ""
}

variable "enabled" {
  type        = bool
  default     = null
  description = "Set to false to prevent the module from creating any resources"
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

variable "private_zone" {
  type        = bool
  description = "Used with `zone_name` input to get a private Hosted Zone."
  default     = null
}

variable "records" {
  type        = list(string)
  description = "DNS records to create"
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

variable "ttl" {
  type        = number
  default     = 300
  description = "The TTL of the record to add to the DNS zone to complete certificate validation"
}

variable "type" {
  type        = string
  default     = "CNAME"
  description = "Type of DNS records to create"
}

variable "zone_id" {
  type        = string
  description = "Route53 DNS Zone ID"
  default     = null
}

variable "zone_name" {
  type        = string
  description = "The Hosted Zone name of the desired Hosted Zone."
  default     = null
}

variable "zone_tags" {
  type        = map(string)
  description = "Used with `zone_name` input. A map of tags, each pair of which must exactly match a pair on the desired Hosted Zone."
  default     = null
}

variable "zone_vpc_id" {
  type        = string
  description = "Used with `zone_name` input to get a private Hosted Zone associated with the `vpc_id` (in this case, private_zone is not mandatory)."
  default     = null
}

