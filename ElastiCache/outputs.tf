output "arn" {
  value       = module.elasticache_redis.arn
  description = "Elasticache Replication Group ARN"
}

output "cluster_enabled" {
  value       = module.elasticache_redis.cluster_enabled
  description = "Indicates if cluster mode is enabled"
}

output "endpoint" {
  value       = module.elasticache_redis.endpoint
  description = "Redis primary, configuration or serverless endpoint, whichever is appropriate for the given configuration"
}

output "engine_version_actual" {
  value       = module.elasticache_redis.engine_version_actual
  description = "The running version of the cache engine"
}

output "host" {
  value       = module.elasticache_redis.host
  description = "Redis hostname"
}

output "id" {
  value       = module.elasticache_redis.id
  description = "Redis cluster ID"
}

output "member_clusters" {
  value       = module.elasticache_redis.member_clusters
  description = "Redis cluster members"
}

output "port" {
  value       = module.elasticache_redis.port
  description = "Redis port"
}

output "reader_endpoint_address" {
  value       = module.elasticache_redis.reader_endpoint_address
  description = "The address of the endpoint for the reader node in the replication group, if the cluster mode is disabled or serverless is being used."
}

output "security_group_id" {
  value       = module.elasticache_redis.security_group_id
  description = "The ID of the created security group"
}

output "security_group_name" {
  value       = module.elasticache_redis.security_group_name
  description = "The name of the created security group"
}

output "serverless_enabled" {
  value       = module.elasticache_redis.serverless_enabled
  description = "Indicates if serverless mode is enabled"
}
