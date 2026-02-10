# AppRunner module

Terraform module for an AWS App Runner service from an ECR or ECR Public image.
Optional: VPC connector, custom domain association, and automatic IAM role for ECR access.

## Features

- **Image source:** ECR or ECR Public (`image_identifier`, `image_repository_type`)
- **Access role:** Pass `access_role_arn` or set `ecr_repository_arn` and the module creates an IAM role for App Runner to pull from ECR
- **VPC connector:** Optional `vpc_connector_subnet_ids` (and optionally `vpc_connector_security_group_ids`) to create a connector, or pass `vpc_connector_arn`
- **Custom domain:** Optional `custom_domain_name` to associate a domain with the service (use with the AcmCustomDomain module for ACM + Route53)
- **Naming:** Uses the terraform-accelerator Label module via `context`

## Usage

### Minimal (ECR Public image)

```hcl
module "apprunner" {
  source = "./AppRunner"

  context = module.this.context

  image_identifier      = "public.ecr.aws/aws-containers/hello-app-runner:latest"
  image_repository_type = "ECR_PUBLIC"
  port                  = "8000"
}
```

### With private ECR (module creates access role)

```hcl
module "apprunner" {
  source = "./AppRunner"

  context = module.this.context

  image_identifier      = "${module.ecr.url}:latest"
  image_repository_type = "ECR"
  port                  = "5000"
  ecr_repository_arn    = module.ecr.arn
}
```

### With custom domain

Set `custom_domain_name` (and optionally `certificate_arn` if your provider supports it).
Use the **AcmCustomDomain** module to create the ACM cert and Route53 CNAME/alias; pass its `certificate_arn` and use `service_url` for the target hostname.

### With VPC connector

```hcl
module "apprunner" {
  source = "./AppRunner"

  context = module.this.context

  image_identifier             = "..."
  image_repository_type        = "ECR"
  port                         = "8080"
  ecr_repository_arn           = module.ecr.arn

  vpc_connector_subnet_ids     = module.vpc.private_subnet_ids
  vpc_connector_security_group_ids = [aws_security_group.apprunner_egress.id]
}
```

## Example

See [example/](example/) for a full runnable setup: ECR, Docker build/push, and App Runner.
Run from `infra/AppRunner/example`:

```bash
terraform init && terraform apply
```

## Inputs / Outputs

See [SPECS.md](SPECS.md) (generated with `terraform-docs markdown table --output-file SPECS.md --output-mode inject ./`).
