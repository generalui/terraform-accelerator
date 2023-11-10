output "arn" {
  value       = module.iam_role.arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "id" {
  value       = module.iam_role.id
  description = "The stable and unique string identifying the role"
}

output "instance_profile" {
  description = "Name of the ec2 profile (if enabled)"
  value       = module.iam_role.instance_profile
}

output "name" {
  value       = module.iam_role.name
  description = "The name of the IAM role created"
}

output "policy" {
  value       = module.iam_role.policy
  description = "Role policy document in json format. Outputs always, independent of `enabled` variable"
}
