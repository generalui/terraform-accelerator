variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}

variable "igw_id" {
  type        = list(string)
  description = <<-EOT
    The Internet Gateway ID that the public subnets will route traffic to.
    Used if `public_route_table_enabled` is `true`, ignored otherwise.
    EOT
  default     = []
  nullable    = false
  validation {
    condition     = length(var.igw_id) < 2
    error_message = "Only 1 igw_id can be provided."
  }
}

variable "max_subnet_count" {
  type        = number
  description = <<-EOT
    Sets the maximum number of each type (public or private) of subnet to deploy.
    `0` will reserve a CIDR for every Availability Zone (excluding Local Zones) in the region, and
    deploy a subnet in each availability zone specified in `availability_zones` or `availability_zone_ids`,
    or every zone if none are specified. We recommend setting this equal to the maximum number of AZs you
    anticipate using, to avoid causing subnets to be destroyed and recreated with smaller IPv4 CIDRs when AWS
    adds an availability zone.
    Due to Terraform limitations, you can not set `max_subnet_count` from a computed value, you have to set it
    from an explicit constant. For most cases, `3` is a good choice.
    EOT
  default     = 0
  nullable    = false
}

variable "availability_zones" {
  type        = list(string)
  description = <<-EOT
    List of Availability Zones (AZs) where subnets will be created. Ignored when `availability_zone_ids` is set.
    The order of zones in the list ***must be stable*** or else Terraform will continually make changes.
    If no AZs are specified, then `max_subnet_count` AZs will be selected in alphabetical order.
    If `max_subnet_count > 0` and `length(var.availability_zones) > max_subnet_count`, the list
    will be truncated. We recommend setting `availability_zones` and `max_subnet_count` explicitly as constant
    (not computed) values for predictability, consistency, and stability.
    EOT
  default     = []
  nullable    = false
}

variable "ipv4_cidr_block" {
  type        = list(string)
  description = <<-EOT
    Base IPv4 CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`). Ignored if `ipv4_cidrs` is set.
    If no CIDR block is provided, the VPC's default IPv4 CIDR block will be used.
    EOT
  default     = []
  nullable    = false
  validation {
    condition     = length(var.ipv4_cidr_block) < 2
    error_message = "Only 1 ipv4_cidr_block can be provided. Use ipv4_cidrs to provide a CIDR per subnet."
  }
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

variable "name" {
  type        = string
  default     = null
  description = <<-EOT
    ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.
    This is the only ID element not also included as a `tag`.
    The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input.
    EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).
    Neither the tag keys nor the tag values will be modified by this module.
    EOT
}
