output "load_balancer_dns" {
  value = aws_lb.api.dns_name
}

output "database_endpoint" {
  value = aws_db_instance.default.endpoint
}
