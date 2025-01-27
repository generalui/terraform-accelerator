variable "ami" {
  type        = string
  description = "AMI to use for the instance. Setting this will ignore `ami_filter` and `ami_owners`."
  default     = null
}

variable "ami_filter" {
  description = "List of maps used to create the AMI filter for the action runner AMI."
  type        = map(list(string))

  default = {
    name = ["amzn2-ami-hvm-2.*-x86_64-ebs"]
  }
}

variable "ami_owners" {
  description = "The list of owners used to select the AMI of action runner instances."
  type        = list(string)
  default     = ["amazon"]
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Whether to associate a public IP to the instance."
}

variable "assign_eip_address" {
  type        = bool
  description = "Assign an Elastic IP address to the instance"
  default     = true
}

variable "disable_api_termination" {
  type        = bool
  description = "Enable EC2 Instance Termination Protection"
  default     = false
}

variable "ebs_block_device_encrypted" {
  type        = bool
  default     = true
  description = "Whether to encrypt the EBS block device"
}

variable "ebs_block_device_volume_size" {
  type        = number
  default     = 0
  description = "The volume size (in GiB) to provision for the EBS block device. Creation skipped if size is 0"
}

variable "ebs_delete_on_termination" {
  type        = bool
  default     = true
  description = "Whether the EBS volume should be destroyed on instance termination"
}

variable "ebs_device_name" {
  type        = string
  default     = "/dev/sdh"
  description = "The name of the EBS block device to mount on the instance"
}

variable "host_name" {
  type        = string
  default     = "bastion"
  description = "The Bastion hostname created in Route53"
}

variable "instance_profile" {
  type        = string
  description = "A pre-defined profile to attach to the instance (default is to build our own)"
  default     = ""
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Bastion instance type"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Key name"
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Whether the metadata service is available"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 1
  description = "The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests."
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = true
  description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2."
}

variable "monitoring" {
  type        = bool
  description = "Launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "root_block_device_encrypted" {
  type        = bool
  default     = true
  description = "Whether to encrypt the root block device"
}

variable "root_block_device_volume_size" {
  type        = number
  default     = 8
  description = "The volume size (in GiB) to provision for the root block device. It cannot be smaller than the AMI it refers to."
}

variable "security_group_description" {
  type        = string
  default     = "Bastion host security group"
  description = "The Security Group description."
}

variable "security_group_enabled" {
  type        = bool
  description = "Whether to create default Security Group for bastion host."
  default     = true
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

variable "security_group_rules" {
  type = list(any)
  default = [
    {
      key         = "bastion_egress"
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
      self        = null # preferable to self = false
      description = "Allow all outbound traffic"
    },
    {
      key         = "bastion_ingress"
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
      self        = null # preferable to self = false
      description = "Allow all inbound to SSH"
    }
  ]
  description = <<-EOT
    A list of maps of Security Group rules.
    The values of map is fully complated with `aws_security_group_rule` resource.
    To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule .
  EOT
}

variable "security_groups" {
  type        = list(string)
  description = "A list of Security Group IDs to associate with bastion host."
  default     = []
}

variable "ssh_user" {
  type        = string
  description = "Default SSH user for this AMI. e.g. `ec2-user` for Amazon Linux and `ubuntu` for Ubuntu systems"
  default     = "ec2-user"
}

variable "ssm_enabled" {
  description = "Enable SSM Agent on Host."
  type        = bool
  default     = true
}

variable "subnets" {
  type        = list(string)
  description = "AWS subnet IDs"
}

variable "user_data" {
  type        = list(string)
  default     = []
  description = "User data content. Will be ignored if `user_data_base64` is set"
}

variable "user_data_base64" {
  type        = string
  description = "The Base64-encoded user data to provide when launching the instances. If this is set then `user_data` will not be used."
  default     = ""
}

variable "user_data_template" {
  type        = string
  default     = "user_data/amazon-linux.sh"
  description = "User Data template to use for provisioning EC2 Bastion Host"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "zone_id" {
  type        = string
  default     = ""
  description = "Route53 DNS Zone ID"
}
