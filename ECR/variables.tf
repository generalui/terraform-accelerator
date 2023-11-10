variable "attributes" {
  type        = list(string)
  default     = []
  description = <<-EOT
    ID element. Additional attributes (e.g. workers or cluster) to add to id, in the order they appear in the list. New attributes are appended to the end of the list. The elements of the list are joined by the delimiter and treated as a single ID element.
    EOT
}

variable "context" {
  type = any
  default = {
    attributes = []
    name       = null
    namespace  = null
    stage      = null
  tags = {} }
  description = <<-EOT
    Single object for setting entire context at once. See description of individual variables for details. Leave string and numeric variables as null to use
    default value. Individual variable settings (non-null) override settings in context object, except for attributes, tags, and additional_tag_map, which are merged.
    EOT
}

variable "enable_lifecycle_policy" {
  type        = bool
  description = "Set to false to prevent the module from adding any lifecycle policies to any repositories"
  default     = true
}

variable "encryption_configuration" {
  type = object({
    encryption_type = string
    kms_key         = any
  })
  description = "ECR encryption configuration"
  default     = null
}

variable "force_delete" {
  type        = bool
  description = "Whether to delete the repository even if it contains images"
  default     = false
}

variable "image_names" {
  type        = list(string)
  default     = []
  description = "List of Docker local image names, used as repository names for AWS ECR "
}

variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
}

variable "max_image_count" {
  type        = number
  description = "How many Docker Image versions AWS ECR will store"
  default     = 500
}

variable "name" {
  type        = string
  default     = null
  description = <<-EOT
    ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'. This is the only ID element not also included as a tag. The "name" tag is set to the full id string. There is no tag with the value of the name input.
    EOT
}

variable "namespace" {
  type        = string
  default     = null
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "organizations_full_access" {
  type        = list(string)
  description = "Organization IDs to provide with full access to the ECR."
  default     = []
}

variable "organizations_push_access" {
  type        = list(string)
  description = "Organization IDs to provide with push access to the ECR"
  default     = []
}

variable "organizations_readonly_access" {
  type        = list(string)
  description = "Organization IDs to provide with readonly access to the ECR."
  default     = []
}

variable "principals_full_access" {
  type        = list(string)
  description = "Principal ARNs to provide with full access to the ECR"
  default     = []
}

variable "principals_push_access" {
  type        = list(string)
  description = "Principal ARNs to provide with push access to the ECR"
  default     = []
}

variable "principals_readonly_access" {
  type        = list(string)
  description = "Principal ARNs to provide with readonly access to the ECR"
  default     = []
}

variable "principals_lambda" {
  type        = list(string)
  description = "Principal account IDs of Lambdas allowed to consume ECR"
  default     = []
}

variable "protected_tags" {
  type        = set(string)
  description = "Name of image tags prefixes that should not be destroyed. Useful if you tag images with names like dev, staging, and prod"
  default     = []
}

variable "scan_images_on_push" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
  default     = true
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
    Additional tags (e.g. {'BusinessUnit': 'XYZ'}). Neither the tag keys nor the tag values will be modified by this module.
    EOT
}

variable "use_fullname" {
  type        = bool
  default     = true
  description = "Set 'true' to use namespace-stage-name for ecr repository name, else name"
}
