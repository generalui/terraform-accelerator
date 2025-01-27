<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_batch_execution_role"></a> [batch\_execution\_role](#module\_batch\_execution\_role) | ../ | n/a |
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | ../ | n/a |
| <a name="module_lambda_access_s3_policy"></a> [lambda\_access\_s3\_policy](#module\_lambda\_access\_s3\_policy) | git::git@github.com:generalui/terraform-accelerator.git//IamPolicy | 1.0.1-IamPolicy |
| <a name="module_lambda_logging_policy"></a> [lambda\_logging\_policy](#module\_lambda\_logging\_policy) | git::git@github.com:generalui/terraform-accelerator.git//IamPolicy | 1.0.1-IamPolicy |
| <a name="module_policy"></a> [policy](#module\_policy) | git::git@github.com:generalui/terraform-accelerator.git//IamPolicy | 1.0.1-IamPolicy |
| <a name="module_this"></a> [this](#module\_this) | git::git@github.com:generalui/terraform-accelerator.git//Label | 1.0.1-Label |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.lambda_access_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_logging_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS profile name as set in the shared credentials file. | `string` | `"default"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region. | `string` | `"us-west-2"` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "enabled": true,<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Current environment, e.g. 'prod', 'staging', 'dev', 'QA', 'performance' | `string` | `"test"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `"xmpl"` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of the project as a whole | `string` | `"Iam-Rule"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->