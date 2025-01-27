output "arn" {
  description = "ARN of the instance"
  value       = try(aws_instance.default[0].arn, null)
}

output "bastion_access_group" {
  value       = try(aws_iam_group.bastion_access[0].name, null)
  description = "Name of AWS IAM Group that is allowed access to the instance"
}

output "bastion_access_group_arn" {
  value       = try(aws_iam_group.bastion_access[0].arn, null)
  description = "ARN of AWS IAM Group that is allowed access to the instance"
}

output "bastion_access_policy_arn" {
  value       = try(module.bastion_access_policy[0].arn, null)
  description = "ARN of AWS IAM policy that allows access to the instance"
}

output "bastion_access_policy_json" {
  value       = try(module.bastion_access_policy[0].json, null)
  description = "JSON of AWS IAM policy that allows access to the instance"
}

output "hostname" {
  value       = try(module.dns[0].hostname, null)
  description = "DNS hostname"
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = try(aws_instance.default[0].id, null)
}

output "instance_id" {
  value       = try(aws_instance.default[0].id, null)
  description = "Instance ID"
}

output "name" {
  description = "Instance name"
  value       = module.this.id
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = try(aws_instance.default[0].private_dns, null)
}

output "private_ip" {
  value       = try(aws_instance.default[0].private_ip, null)
  description = "Private IP of the instance"
}

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = try(local.public_dns, null)
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
