<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.53.0 |
| <a name="provider_docker"></a> [docker](#provider\_docker) | 3.0.2 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.11.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_batch_compute"></a> [aws\_batch\_compute](#module\_aws\_batch\_compute) | ../ | n/a |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | git::git@github.com:generalui/terraform-accelerator.git//ECR | 1.0.1-ECR |
| <a name="module_read_iam_role"></a> [read\_iam\_role](#module\_read\_iam\_role) | git::git@github.com:generalui/terraform-accelerator.git//IamRole | 1.0.1-IamRole |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | git::git@github.com:generalui/terraform-accelerator.git//Subnet | 1.0.1-Subnet |
| <a name="module_this"></a> [this](#module\_this) | git::git@github.com:generalui/terraform-accelerator.git//Label | 1.0.1-Label |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::git@github.com:generalui/terraform-accelerator.git//VPC | 1.0.1-VPC |
| <a name="module_vpc_endpoint_security_group"></a> [vpc\_endpoint\_security\_group](#module\_vpc\_endpoint\_security\_group) | git::git@github.com:generalui/terraform-accelerator.git//SecurityGroup | 1.0.1-SecurityGroup |
| <a name="module_write_iam_role"></a> [write\_iam\_role](#module\_write\_iam\_role) | git::git@github.com:generalui/terraform-accelerator.git//IamRole | 1.0.1-IamRole |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.batch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_launch_template.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_sns_topic.health](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.health](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [docker_image.this](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [docker_registry_image.this](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/registry_image) | resource |
| [time_static.activation_date](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecr_authorization_token.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_authorization_token) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS profile name as set in the shared credentials file. | `string` | `"default"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region. | `string` | `"us-west-2"` | no |
| <a name="input_batch_ecr_tag"></a> [batch\_ecr\_tag](#input\_batch\_ecr\_tag) | The version tag for the of the batch ECR image to use. | `string` | `"example-python-batch"` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Current environment, e.g. 'prod', 'staging', 'dev', 'QA', 'performance' | `string` | `"test"` | no |
| <a name="input_health_emails"></a> [health\_emails](#input\_health\_emails) | The email addresses to send health notifications to. | `list(string)` | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `"xmpl"` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of the project as a whole | `string` | `"Aws-Batch"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->