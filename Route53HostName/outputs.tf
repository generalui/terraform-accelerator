output "hostname" {
  value       = module.route53_hostname.hostname
  description = "DNS hostname"
}
