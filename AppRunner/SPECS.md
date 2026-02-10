<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.18 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apprunner_access_role"></a> [apprunner\_access\_role](#module\_apprunner\_access\_role) | git::git@github.com:generalui/terraform-accelerator.git//IamRole | 1.0.1-IamRole |
| <a name="module_ecr_access_policy"></a> [ecr\_access\_policy](#module\_ecr\_access\_policy) | git::git@github.com:ohgod-ai/eo-terraform.git//IamPolicy | 1.0.1-IamPolicy |
| <a name="module_this"></a> [this](#module\_this) | git::git@github.com:generalui/terraform-accelerator.git//Label | 1.0.1-Label |

## Resources

| Name | Type |
|------|------|
| [aws_apprunner_custom_domain_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_custom_domain_association) | resource |
| [aws_apprunner_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_service) | resource |
| [aws_apprunner_vpc_connector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_vpc_connector) | resource |
| [aws_iam_role_policy_attachment.ecr_access_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_role_arn"></a> [access\_role\_arn](#input\_access\_role\_arn) | ARN of IAM role for App Runner to pull the image from ECR. Required for private ECR when not creating a role. When null and ecr\_repository\_arn is set, the module creates a role. | `string` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_auto_deployments_enabled"></a> [auto\_deployments\_enabled](#input\_auto\_deployments\_enabled) | Whether automatic deployments from the source repository are enabled (e.g. new image tag). | `bool` | `false` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN of ACM certificate for the custom domain. Required when custom\_domain\_name is set if the certificate is not in us-east-1 (App Runner uses us-east-1 for cert validation in some cases). | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes and tags, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "enabled": true,<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Number of CPU units for each instance. Valid values: 256, 512, 1024, 2048, 4096 (or 0.25, 0.5, 1, 2, 4 vCPU). | `string` | `"1024"` | no |
| <a name="input_custom_domain_name"></a> [custom\_domain\_name](#input\_custom\_domain\_name) | Custom domain name to associate with the App Runner service (e.g. app.example.com). | `string` | `null` | no |
| <a name="input_ecr_repository_arn"></a> [ecr\_repository\_arn](#input\_ecr\_repository\_arn) | ARN of the ECR repository. Used only when access\_role\_arn is null to create an access role with least-privilege ECR pull for this repository. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Environment name, e.g. prod, staging, dev. | `string` | `null` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | URL path for HTTP health checks. | `string` | `"/"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | Protocol for health checks. Valid values: TCP, HTTP. | `string` | `"HTTP"` | no |
| <a name="input_image_identifier"></a> [image\_identifier](#input\_image\_identifier) | Full image identifier (e.g. ECR URL or ECR Public URL). For ECR: `account.dkr.ecr.region.amazonaws.com/repo:tag`. For ECR Public: `public.ecr.aws/.../image:tag`. | `string` | n/a | yes |
| <a name="input_image_repository_type"></a> [image\_repository\_type](#input\_image\_repository\_type) | Type of the image repository. Valid values: `ECR`, `ECR_PUBLIC`. | `string` | `"ECR"` | no |
| <a name="input_instance_role_arn"></a> [instance\_role\_arn](#input\_instance\_role\_arn) | Optional ARN of IAM role for the running service (permissions your code needs when calling AWS APIs). | `string` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory reserved for each instance (e.g. 512, 1024, 2048, 3072, 4096, 6144, 8192, 10240, 12288 MB, or 0.5, 1, 2, 3, 4, 6, 8, 10, 12 GB). | `string` | `"2048"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | Port that your application listens to in the container. | `string` | `"8080"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name. | `string` | `"apprunner"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_vpc_connector_arn"></a> [vpc\_connector\_arn](#input\_vpc\_connector\_arn) | ARN of an existing App Runner VPC connector. If set, used instead of creating one (vpc\_connector\_subnet\_ids and vpc\_connector\_security\_group\_ids are ignored). | `string` | `null` | no |
| <a name="input_vpc_connector_security_group_ids"></a> [vpc\_connector\_security\_group\_ids](#input\_vpc\_connector\_security\_group\_ids) | List of security group IDs for the VPC connector. Required when vpc\_connector\_subnet\_ids is set. | `list(string)` | `null` | no |
| <a name="input_vpc_connector_subnet_ids"></a> [vpc\_connector\_subnet\_ids](#input\_vpc\_connector\_subnet\_ids) | List of subnet IDs for the VPC connector. When set, a VPC connector is created and the service egress is set to VPC. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_role_arn"></a> [access\_role\_arn](#output\_access\_role\_arn) | ARN of the IAM access role used for ECR pull (if created by this module). |
| <a name="output_custom_domain_certificate_validation_records"></a> [custom\_domain\_certificate\_validation\_records](#output\_custom\_domain\_certificate\_validation\_records) | Certificate validation records for the custom domain (add CNAME to DNS). |
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | ARN of the App Runner service. |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | App Runner service ID (unique within the region). |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | Name of the App Runner service. |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | Current state of the App Runner service. |
| <a name="output_service_url"></a> [service\_url](#output\_service\_url) | Subdomain URL that App Runner generated for this service (HTTPS). |
| <a name="output_vpc_connector_arn"></a> [vpc\_connector\_arn](#output\_vpc\_connector\_arn) | ARN of the VPC connector (if created by this module). |
<!-- END_TF_DOCS -->