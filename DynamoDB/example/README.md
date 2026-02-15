# DynamoDB example

Runnable example: single DynamoDB table with a string hash key, on-demand billing, encryption, and point-in-time recovery enabled.

## Prerequisites

- AWS CLI configured (profile or default)
- Terraform >= 1.3

## Run

```bash
cd DynamoDB/example
terraform init
terraform apply
```

## Clean up

```bash
terraform destroy
```

## What it creates

- **Label** (context / naming: `namespace` + `project` + `environment_name`, e.g. `xmpl-dynamodb-test`)
- **DynamoDB table** with:
  - Hash key `id` (string)
  - On-demand billing
  - Server-side encryption and PITR enabled (defaults)

## Variables

Override as needed, e.g. `-var="aws_region=us-east-1"` or a `.tfvars` file.
Key variables: `aws_profile`, `aws_region`, `project`, `namespace`, `environment_name`.
