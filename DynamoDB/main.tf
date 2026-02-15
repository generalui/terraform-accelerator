# DynamoDB table — native aws_dynamodb_table with Label-based naming.
# Encryption and PITR enabled by default; on-demand billing; full attribute/key_schema.

locals {
  hash_key_name  = [for k in var.key_schema : k.name if k.key_type == "HASH"][0]
  range_key_name = try([for k in var.key_schema : k.name if k.key_type == "RANGE"][0], null)
  ttl_enabled    = var.ttl_attribute_name != null && coalesce(var.ttl_enabled, true)
}

resource "aws_dynamodb_table" "this" {
  count = module.this.enabled ? 1 : 0

  name         = module.this.id
  billing_mode = var.billing_mode

  hash_key  = local.hash_key_name
  range_key = local.range_key_name

  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null

  dynamic "attribute" {
    for_each = var.attribute
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  server_side_encryption {
    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.kms_key_arn
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "ttl" {
    for_each = var.ttl_attribute_name != null ? [1] : []
    content {
      enabled        = local.ttl_enabled
      attribute_name = var.ttl_attribute_name
    }
  }

  tags = module.this.tags
}
