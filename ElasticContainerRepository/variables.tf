variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "The name of the repository"
  type        = string
  default     = ""
}

variable "allowed_arns" {
  description = "The ARNs of the IAM users/roles that have read/write access to the repository"
  type        = list(string)
  default     = []
}
