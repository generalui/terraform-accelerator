# AWS EC2 Bastion Server
# Terraform module to define a generic Bastion host with parameterized `user_data` and support for AWS SSM Session Manager for remote access with IAM authentication.

locals {
  create_instance_profile = module.this.enabled && try(length(var.instance_profile), 0) == 0
  instance_profile        = local.create_instance_profile ? join("", aws_iam_instance_profile.default.*.name) : var.instance_profile
  eip_enabled             = var.associate_public_ip_address && var.assign_eip_address && module.this.enabled
  security_group_enabled  = module.this.enabled && var.security_group_enabled
  public_dns              = local.eip_enabled ? local.public_dns_rendered : join("", aws_instance.default.*.public_dns)
  public_dns_rendered = local.eip_enabled ? format("ec2-%s.%s.amazonaws.com",
    replace(join("", aws_eip.default.*.public_ip), ".", "-"),
    data.aws_region.default.name == "us-east-1" ? "compute-1" : format("%s.compute", data.aws_region.default.name)
  ) : null
  user_data_templated = templatefile("${path.module}/${var.user_data_template}", {
    user_data   = join("\n", var.user_data)
    ssm_enabled = var.ssm_enabled
    ssh_user    = var.ssh_user
  })
}

data "aws_region" "default" {}

data "aws_ami" "default" {
  count = module.this.enabled && var.ami == null ? 1 : 0

  most_recent = "true"

  dynamic "filter" {
    for_each = var.ami_filter
    content {
      name   = filter.key
      values = filter.value
    }
  }

  owners = var.ami_owners
}

module "bastion_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name   = "${module.this.id}-sg"
  vpc_id = var.vpc_id

  // No need for Ingress, use SSM to connect.

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["postgresql-tcp", "http-80-tcp", "https-443-tcp"]

  tags = merge(module.this.tags, { Name = "${module.this.id}-sg" })
}

data "aws_route53_zone" "domain" {
  count   = module.this.enabled && try(length(var.zone_id), 0) > 0 ? 1 : 0
  zone_id = var.zone_id
}

resource "aws_instance" "default" {
  #bridgecrew:skip=BC_AWS_PUBLIC_12: Skipping `EC2 Should Not Have Public IPs` check. NAT instance requires public IP.
  #bridgecrew:skip=BC_AWS_GENERAL_31: Skipping `Ensure Instance Metadata Service Version 1 is not enabled` check until BridgeCrew support condition evaluation. See https://github.com/bridgecrewio/checkov/issues/793
  count                       = module.this.enabled ? 1 : 0
  ami                         = coalesce(var.ami, join("", data.aws_ami.default.*.id))
  instance_type               = var.instance_type
  user_data                   = length(var.user_data_base64) > 0 ? var.user_data_base64 : local.user_data_templated
  vpc_security_group_ids      = compact(concat(module.bastion_security_group.*.security_group_id, var.security_groups))
  iam_instance_profile        = local.instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  subnet_id                   = var.subnets[0]
  monitoring                  = var.monitoring
  disable_api_termination     = var.disable_api_termination

  metadata_options {
    http_endpoint               = (var.metadata_http_endpoint_enabled) ? "enabled" : "disabled"
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = (var.metadata_http_tokens_required) ? "required" : "optional"
  }

  root_block_device {
    encrypted   = var.root_block_device_encrypted
    volume_size = var.root_block_device_volume_size
  }

  # Optional block; skipped if var.ebs_block_device_volume_size is zero
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device_volume_size > 0 ? [1] : []

    content {
      encrypted             = var.ebs_block_device_encrypted
      volume_size           = var.ebs_block_device_volume_size
      delete_on_termination = var.ebs_delete_on_termination
      device_name           = var.ebs_device_name
    }
  }

  tags = module.this.tags
}

resource "aws_eip" "default" {
  count    = local.eip_enabled ? 1 : 0
  instance = join("", aws_instance.default.*.id)
  domain   = "vpc"
  tags     = module.this.tags
}

module "dns" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//Route53HostName?ref=1.0.0"

  enabled  = module.this.enabled && try(length(var.zone_id), 0) > 0 ? true : false
  zone_id  = var.zone_id
  ttl      = 60
  records  = var.associate_public_ip_address ? tolist([local.public_dns]) : tolist([join("", aws_instance.default.*.private_dns)])
  context  = module.this.context
  dns_name = var.host_name
}

resource "aws_iam_group" "bastion_access" {
  name = "${module.this.id}-access"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "bastion_access" {
  group      = aws_iam_group.bastion_access.name
  policy_arn = module.bastion_access_policy.arn
}

module "bastion_access_policy" {
  source = "git::git@github.com:ohgod-ai/eo-terraform.git//IamPolicy?ref=1.0.0"

  name    = "${module.this.id}-access"
  context = module.this.context

  description = "Allows accessing the bastion"
  iam_policy = [{
    version   = "2012-10-17"
    policy_id = "BastionAccess"
    statements = [
      {
        sid     = "StartSsmSession"
        effect  = "Allow"
        actions = ["ssm:StartSession"]
        resources = [
          "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:instance/${aws_instance.default[0].id}",
          "arn:aws:ssm:${var.aws_region}::document/AWS-StartPortForwardingSessionToRemoteHost"
        ]
      },
      {
        sid       = "EndSsmSession"
        effect    = "Allow"
        actions   = ["ssm:TerminateSession"]
        resources = ["arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:session/*"]
      }
    ]
  }]
  iam_policy_enabled = module.this.enabled
}
