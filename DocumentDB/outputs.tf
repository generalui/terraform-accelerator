output "master_username" {
  value       = module.documentdb-cluster.master_username
  description = "Username for the master DB user"
}

output "master_password" {
  value       = module.documentdb-cluster.master_password
  description = "Password for the master DB user"
  sensitive   = true
}

output "cluster_name" {
  value       = module.documentdb-cluster.cluster_name
  description = "Cluster Identifier"
}

output "arn" {
  value       = module.documentdb-cluster.arn
  description = "Amazon Resource Name (ARN) of the cluster"
}

output "endpoint" {
  value       = module.documentdb-cluster.endpoint
  description = "Endpoint of the DocumentDB cluster"
}

output "reader_endpoint" {
  value       = module.documentdb-cluster.reader_endpoint
  description = "A read-only endpoint of the DocumentDB cluster, automatically load-balanced across replicas"
}

output "master_host" {
  value       = module.documentdb-cluster.master_host
  description = "DB master hostname"
}

output "replicas_host" {
  value       = module.documentdb-cluster.replicas_host
  description = "DB replicas hostname"
}

output "security_group_id" {
  description = "ID of the DocumentDB cluster Security Group"
  value       = module.documentdb-cluster.security_group_id
}

output "security_group_arn" {
  description = "ARN of the DocumentDB cluster Security Group"
  value       = module.documentdb-cluster.security_group_arn
}

output "security_group_name" {
  description = "Name of the DocumentDB cluster Security Group"
  value       = module.documentdb-cluster.security_group_name
}
