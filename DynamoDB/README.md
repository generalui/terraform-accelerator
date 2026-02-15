# AWS DynamoDB

This module creates a single DynamoDB table using native `aws_dynamodb_table`. Naming uses the terraform-accelerator Label module via `context`.
See the [example](./example/) for a minimal runnable setup.

## Features

- **Schema:** Full control via `attribute` (list of name/type) and `key_schema` (list of name/key_type HASH|RANGE).
- **Billing:** On-demand by default (`PAY_PER_REQUEST`); optional provisioned capacity.
- **Security/compliance:** Server-side encryption enabled by default; optional KMS key; point-in-time recovery enabled by default.
- **Optional:** DynamoDB Streams, TTL.

## Usage

### Minimal (hash key only, on-demand, encrypted, PITR)

```hcl
module "dynamodb" {
  source = "./DynamoDB"

  context = module.this.context

  attribute = [
    { name = "id", type = "S" }
  ]
  key_schema = [
    { name = "id", key_type = "HASH" }
  ]
}
```

### With range key and TTL

```hcl
module "dynamodb" {
  source = "./DynamoDB"

  context = module.this.context

  attribute = [
    { name = "pk", type = "S" },
    { name = "sk", type = "S" },
    { name = "ttl", type = "N" }
  ]
  key_schema = [
    { name = "pk", key_type = "HASH" },
    { name = "sk", key_type = "RANGE" }
  ]
  ttl_attribute_name = "ttl"
}
```

### With streams

```hcl
module "dynamodb" {
  source = "./DynamoDB"

  context = module.this.context

  attribute = [
    { name = "id", type = "S" }
  ]
  key_schema = [
    { name = "id", key_type = "HASH" }
  ]
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}
```

### Provisioned capacity

Set `billing_mode = "PROVISIONED"` and provide `read_capacity` and `write_capacity`.

## Module Specs

[SPECS.md](./SPECS.md)
