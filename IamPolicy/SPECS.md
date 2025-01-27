<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_policy"></a> [iam\_policy](#module\_iam\_policy) | cloudposse/iam-policy/aws | 2.0.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | Description of created IAM policy | `string` | `null` | no |
| <a name="input_iam_override_policy_documents"></a> [iam\_override\_policy\_documents](#input\_iam\_override\_policy\_documents) | List of IAM policy documents (as JSON strings) that are merged together into the exported document with higher precedence.<br>In merging, statements with non-blank SIDs will override statements with the same SID<br>from earlier documents in the list and from other "source" documents. | `list(string)` | `null` | no |
| <a name="input_iam_policy"></a> [iam\_policy](#input\_iam\_policy) | IAM policy as list of Terraform objects, compatible with Terraform `aws_iam_policy_document` data source<br>except that `source_policy_documents` and `override_policy_documents` are not included.<br>Use inputs `iam_source_policy_documents` and `iam_override_policy_documents` for that. | <pre>list(object({<br>    policy_id = optional(string, null)<br>    version   = optional(string, null)<br>    statements = list(object({<br>      sid           = optional(string, null)<br>      effect        = optional(string, null)<br>      actions       = optional(list(string), null)<br>      not_actions   = optional(list(string), null)<br>      resources     = optional(list(string), null)<br>      not_resources = optional(list(string), null)<br>      conditions = optional(list(object({<br>        test     = string<br>        variable = string<br>        values   = list(string)<br>      })), [])<br>      principals = optional(list(object({<br>        type        = string<br>        identifiers = list(string)<br>      })), [])<br>      not_principals = optional(list(object({<br>        type        = string<br>        identifiers = list(string)<br>      })), [])<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_iam_policy_enabled"></a> [iam\_policy\_enabled](#input\_iam\_policy\_enabled) | If set to `true` will create the IAM policy in AWS, otherwise will only output policy as JSON. | `bool` | `false` | no |
| <a name="input_iam_source_json_url"></a> [iam\_source\_json\_url](#input\_iam\_source\_json\_url) | URL of the IAM policy (in JSON format) to download and use as `source_json` argument.<br>This is useful when using a 3rd party service that provides their own policy.<br>Statements in this policy will be overridden by statements with the same SID in `iam_override_policy_documents`. | `string` | `null` | no |
| <a name="input_iam_source_policy_documents"></a> [iam\_source\_policy\_documents](#input\_iam\_source\_policy\_documents) | List of IAM policy documents (as JSON strings) that are merged together into the exported document.<br>Statements defined in `iam_source_policy_documents` must have unique SIDs and be distinct from SIDs<br>in `iam_policy` and deprecated `iam_policy_statements`.<br>Statements in these documents will be overridden by statements with the same SID in `iam_override_policy_documents`. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of created IAM policy |
| <a name="output_json"></a> [json](#output\_json) | JSON body of the IAM policy document |
<!-- END_TF_DOCS -->