resource "aws_cloudwatch_log_group" "batch" {
  name = module.this.name
  // Optional: configure retention in days
  retention_in_days = 1

  tags = merge(module.this.tags, { Name = "/${module.this.name}" })
}
