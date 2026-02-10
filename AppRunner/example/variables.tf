variable "aws_profile" {
  type        = string
  default     = "default"
  description = "AWS profile name from shared credentials file."
}

variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region."
}
