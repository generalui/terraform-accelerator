locals {
  account_id              = data.aws_caller_identity.current.account_id
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
