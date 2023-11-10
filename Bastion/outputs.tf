output "arn" {
  description = "ARN of the instance"
  value       = join("", aws_instance.default.*.arn)
}

output "bastion_access_group" {
  value       = join("", aws_iam_group.bastion_access.name)
  description = "Name of AWS IAM Group that is allowed access to the instance"
}

output "bastion_access_group_arn" {
  value       = join("", aws_iam_group.bastion_access.arn)
  description = "ARN of AWS IAM Group that is allowed access to the instance"
}

output "hostname" {
  value       = module.dns.hostname
  description = "DNS hostname"
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = join("", aws_instance.default.*.id)
}

output "instance_id" {
  value       = join("", aws_instance.default.*.id)
  description = "Instance ID"
}

output "name" {
  description = "Instance name"
  value       = module.this.id
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = join("", aws_instance.default.*.private_dns)
}

output "private_ip" {
  value       = join("", aws_instance.default.*.private_ip)
  description = "Private IP of the instance"
}

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = local.public_dns
}

output "public_ip" {
  value       = concat(aws_eip.default.*.public_ip, aws_instance.default.*.public_ip, [""])[0]
  description = "Public IP of the instance (or EIP)"
}

output "role" {
  value       = join("", aws_iam_role.default.*.name)
  description = "Name of AWS IAM Role associated with the instance"
}

output "security_group_arn" {
  value       = module.bastion_security_group.security_group_arn
  description = "Bastion host Security Group ARN"
}

output "security_group_id" {
  value       = module.bastion_security_group.security_group_id
  description = "Bastion host Security Group ID"
}

output "security_group_ids" {
  description = "IDs on the AWS Security Groups associated with the instance"
  value = compact(
    concat(
      formatlist("%s", module.bastion_security_group.security_group_id),
      var.security_groups
    )
  )
}

output "security_group_name" {
  value       = module.bastion_security_group.security_group_name
  description = "Bastion host Security Group name"
}

output "ssh_user" {
  value       = var.ssh_user
  description = "SSH user"
}
