output "id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "cidr_block" {
  description = "The primary IPv4 CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = module.vpc.vpc_main_route_table_id
}

output "default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation"
  value       = module.vpc.vpc_default_network_acl_id
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.vpc.vpc_default_security_group_id
}

output "default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value       = module.vpc.vpc_default_route_table_id
}

output "ipv6_association_id" {
  description = "The association ID for the primary IPv6 CIDR block"
  value       = module.vpc.vpc_ipv6_association_id
}

output "ipv6_cidr_block" {
  description = "The primary IPv6 CIDR block"
  value       = module.vpc.vpc_ipv6_cidr_block
}

output "additional_cidr_blocks" {
  description = "A list of the additional IPv4 CIDR blocks associated with the VPC"
  value       = module.vpc.additional_cidr_blocks
}

output "additional_cidr_blocks_to_association_ids" {
  description = "A map of the additional IPv4 CIDR blocks to VPC CIDR association IDs"
  value       = module.vpc.additional_cidr_blocks_to_association_ids
}

output "additional_ipv6_cidr_blocks" {
  description = "A list of the additional IPv6 CIDR blocks associated with the VPC"
  value       = module.vpc.additional_ipv6_cidr_blocks
}

output "additional_ipv6_cidr_blocks_to_association_ids" {
  description = "A map of the additional IPv6 CIDR blocks to VPC CIDR association IDs"
  value       = module.vpc.additional_ipv6_cidr_blocks_to_association_ids
}

output "ipv6_cidr_block_network_border_group" {
  description = "The IPv6 Network Border Group Zone name"
  value       = module.vpc.ipv6_cidr_block_network_border_group
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

output "ipv6_egress_only_igw_id" {
  description = "The ID of the egress-only Internet Gateway"
  value       = module.vpc.ipv6_egress_only_igw_id
}
