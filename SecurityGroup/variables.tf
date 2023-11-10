variable "allow_all_egress" {
  type        = bool
  description = <<-EOT
    A convenience that adds to the rules specified elsewhere a rule that allows all egress.
    If this is false and no egress rules are specified via `rules` or `rule-matrix`, then no egress will be allowed.
    EOT
  default     = true
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
    enabled    = true
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

variable "preserve_security_group_id" {
  type        = bool
  description = <<-EOT
    When `false` and `create_before_destroy` is `true`, changes to security group rules
    cause a new security group to be created with the new rules, and the existing security group is then
    replaced with the new one, eliminating any service interruption.
    When `true` or when changing the value (from `false` to `true` or from `true` to `false`),
    existing security group rules will be deleted before new ones are created, resulting in a service interruption,
    but preserving the security group itself.
    **NOTE:** Setting this to `true` does not guarantee the security group will never be replaced,
    it only keeps changes to the security group rules from triggering a replacement.
    See the README for further discussion.
    EOT
  default     = false
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = <<-EOT
    Instruct Terraform to revoke all of the Security Group's attached ingress and egress rules before deleting
    the security group itself. This is normally not needed.
    EOT
  default     = false
}

variable "rule_matrix" {
  # rule_matrix is independent of the `rules` input.
  # Only the rules specified in the `rule_matrix` object are applied to the subjects specified in `rule_matrix`.
  # The `key` attributes are optional, but if supplied, must be known at plan time or else
  # you will get an error from Terraform. If the value is triggering an error, just omit it.
  #  Schema:
  #  {
  #    # these top level lists define all the subjects to which rule_matrix rules will be applied
  #    key = unique key (for stability from plan to plan)
  #    source_security_group_ids = list of source security group IDs to apply all rules to
  #    cidr_blocks = list of ipv4 CIDR blocks to apply all rules to
  #    ipv6_cidr_blocks = list of ipv6 CIDR blocks to apply all rules to
  #    prefix_list_ids = list of prefix list IDs to apply all rules to
  #    self = # set "true" to apply the rules to the created or existing security group
  #
  #    # each rule in the rules list will be applied to every subject defined above
  #    rules = [{
  #      key = "unique key"
  #      type = "ingress"
  #      from_port = 433
  #      to_port = 433
  #      protocol = "tcp"
  #      description = "Allow HTTPS ingress"
  #    }]

  type        = any
  description = <<-EOT
    A convenient way to apply the same set of rules to a set of subjects. See README for details.
    EOT
  default     = []
}

variable "rules" {
  type        = list(any)
  description = <<-EOT
    A list of Security Group rule objects. All elements of a list must be exactly the same type;
    use `rules_map` if you want to supply multiple lists of different types.
    The keys and values of the Security Group rule objects are fully compatible with the `aws_security_group_rule` resource,
    except for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique
    and known at "plan" time.
    To get more info see the `security_group_rule` [documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule).
    ___Note:___ The length of the list must be known at plan time.
    This means you cannot use functions like `compact` or `sort` when computing the list.
    EOT
  default     = []
}

variable "rules_map" {
  type        = any
  description = <<-EOT
    A map-like object of lists of Security Group rule objects. All elements of a list must be exactly the same type,
    so this input accepts an object with keys (attributes) whose values are lists so you can separate different
    types into different lists and still pass them into one input. Keys must be known at "plan" time.
    The keys and values of the Security Group rule objects are fully compatible with the `aws_security_group_rule` resource,
    except for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique
    and known at "plan" time.
    To get more info see the `security_group_rule` [documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule).
    EOT
  default     = {}
}

variable "security_group_create_timeout" {
  type        = string
  description = "How long to wait for the security group to be created."
  default     = "10m"
}

variable "security_group_delete_timeout" {
  type        = string
  description = <<-EOT
    How long to retry on `DependencyViolation` errors during security group deletion from
    lingering ENIs left by certain AWS services such as Elastic Load Balancing.
    EOT
  default     = "15m"
}

variable "security_group_description" {
  type        = string
  description = <<-EOT
    The description to assign to the created Security Group.
    Warning: Changing the description causes the security group to be replaced.
    EOT
  default     = "Managed by Terraform"
}

variable "security_group_name_prefix" {
  type        = list(string)
  description = <<-EOT
    The name prefix to assign to the security group. The name must be unique within the VPC.
    If not provided, will be derived from the `null-label.context` passed in.
    EOT
  default     = []
  validation {
    condition     = length(var.security_group_name_prefix) < 2
    error_message = "Only 1 security group name can be provided."
  }
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

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the Security Group will be created."
}
