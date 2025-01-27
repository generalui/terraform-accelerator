output "access_logs_bucket_id" {
  description = "The S3 bucket ID for access logs"
  value       = module.access_logs.bucket_id
}

output "arn" {
  description = "The ARN of the ALB"
  value       = one(aws_lb.default[*].arn)
}

output "arn_suffix" {
  description = "The ARN suffix of the ALB"
  value       = one(aws_lb.default[*].arn_suffix)
}

output "default_target_group_arn" {
  description = "The default target group ARN"
  value       = one(aws_lb_target_group.default[*].arn)
}

output "default_target_group_arn_suffix" {
  description = "The default target group ARN suffix"
  value       = one(aws_lb_target_group.default[*].arn_suffix)
}

output "dns_name" {
  description = "DNS name of ALB"
  value       = one(aws_lb.default[*].dns_name)
}

output "http_listener_arn" {
  description = "The ARN of the HTTP forwarding listener"
  value       = one(aws_lb_listener.http_forward[*].arn)
}

output "http_redirect_listener_arn" {
  description = "The ARN of the HTTP to HTTPS redirect listener"
  value       = one(aws_lb_listener.http_redirect[*].arn)
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = one(aws_lb_listener.https[*].arn)
}

output "listener_arns" {
  description = "A list of all the listener ARNs"
  value = compact(
    concat(aws_lb_listener.http_forward[*].arn, aws_lb_listener.http_redirect[*].arn, aws_lb_listener.https[*].arn)
  )
}

output "name" {
  description = "The ARN suffix of the ALB"
  value       = one(aws_lb.default[*].name)
}

output "security_group_id" {
  description = "The security group ID of the ALB"
  value       = one(aws_security_group.default[*].id)
}

output "zone_id" {
  description = "The ID of the zone which ALB is provisioned"
  value       = one(aws_lb.default[*].zone_id)
}
