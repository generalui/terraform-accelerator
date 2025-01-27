output "arn" {
  value       = try(module.elasticache_redis.arn, null)
  description = "Elasticache Replication Group ARN"
}

output "cluster_enabled" {
  value       = try(module.elasticache_redis.cluster_enabled, null)
  description = "Indicates if cluster mode is enabled"
}

output "endpoint" {
  value       = try(module.elasticache_redis.endpoint, null)
  description = "Redis primary, configuration or serverless endpoint, whichever is appropriate for the given configuration"
}

output "engine_version_actual" {
  value       = try(module.elasticache_redis.engine_version_actual, null)
  description = "The running version of the cache engine"
}

output "host" {
  value       = try(module.elasticache_redis.host, null)
  description = "Redis hostname"
}

output "id" {
  value       = try(module.elasticache_redis.id, null)
  description = "Redis cluster ID"
}

output "member_clusters" {
  value       = try(module.elasticache_redis.member_clusters, null)
  description = "Redis cluster members"
}

output "port" {
  value       = try(module.elasticache_redis.port, null)
  description = "Redis port"
}

output "reader_endpoint_address" {
  value       = try(module.elasticache_redis.reader_endpoint_address, null)
  description = "The address of the endpoint for the reader node in the replication group, if the cluster mode is disabled or serverless is being used."
}

output "security_group_id" {
  value       = try(module.elasticache_redis.security_group_id, null)
  description = "The ID of the created security group"
}

output "security_group_name" {
  value       = try(module.elasticache_redis.security_group_name, null)
  description = "The name of the created security group"
}

output "serverless_enabled" {
  value       = try(module.elasticache_redis.serverless_enabled, null)
  description = "Indicates if serverless mode is enabled"
}
