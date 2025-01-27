<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | cloudposse/ecr/aws | 0.40.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. workers or cluster) to add to id, in the order they appear in the list. New attributes are appended to the end of the list. The elements of the list are joined by the delimiter and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once. See description of individual variables for details. Leave string and numeric variables as null to use<br>default value. Individual variable settings (non-null) override settings in context object, except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_enable_lifecycle_policy"></a> [enable\_lifecycle\_policy](#input\_enable\_lifecycle\_policy) | Set to false to prevent the module from adding any lifecycle policies to any repositories | `bool` | `true` | no |
| <a name="input_encryption_configuration"></a> [encryption\_configuration](#input\_encryption\_configuration) | ECR encryption configuration | <pre>object({<br>    encryption_type = string<br>    kms_key         = any<br>  })</pre> | `null` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Whether to delete the repository even if it contains images | `bool` | `false` | no |
| <a name="input_image_names"></a> [image\_names](#input\_image\_names) | List of Docker local image names, used as repository names for AWS ECR | `list(string)` | `[]` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE | `string` | `"IMMUTABLE"` | no |
| <a name="input_max_image_count"></a> [max\_image\_count](#input\_max\_image\_count) | How many Docker Image versions AWS ECR will store | `number` | `500` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'. This is the only ID element not also included as a tag. The "name" tag is set to the full id string. There is no tag with the value of the name input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_organizations_full_access"></a> [organizations\_full\_access](#input\_organizations\_full\_access) | Organization IDs to provide with full access to the ECR. | `list(string)` | `[]` | no |
| <a name="input_organizations_push_access"></a> [organizations\_push\_access](#input\_organizations\_push\_access) | Organization IDs to provide with push access to the ECR | `list(string)` | `[]` | no |
| <a name="input_organizations_readonly_access"></a> [organizations\_readonly\_access](#input\_organizations\_readonly\_access) | Organization IDs to provide with readonly access to the ECR. | `list(string)` | `[]` | no |
| <a name="input_principals_full_access"></a> [principals\_full\_access](#input\_principals\_full\_access) | Principal ARNs to provide with full access to the ECR | `list(string)` | `[]` | no |
| <a name="input_principals_lambda"></a> [principals\_lambda](#input\_principals\_lambda) | Principal account IDs of Lambdas allowed to consume ECR | `list(string)` | `[]` | no |
| <a name="input_principals_push_access"></a> [principals\_push\_access](#input\_principals\_push\_access) | Principal ARNs to provide with push access to the ECR | `list(string)` | `[]` | no |
| <a name="input_principals_readonly_access"></a> [principals\_readonly\_access](#input\_principals\_readonly\_access) | Principal ARNs to provide with readonly access to the ECR | `list(string)` | `[]` | no |
| <a name="input_protected_tags"></a> [protected\_tags](#input\_protected\_tags) | Name of image tags prefixes that should not be destroyed. Useful if you tag images with names like dev, staging, and prod | `set(string)` | `[]` | no |
| <a name="input_scan_images_on_push"></a> [scan\_images\_on\_push](#input\_scan\_images\_on\_push) | Indicates whether images are scanned after being pushed to the repository (true) or not (false) | `bool` | `true` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. {'BusinessUnit': 'XYZ'}). Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_use_fullname"></a> [use\_fullname](#input\_use\_fullname) | Set 'true' to use namespace-stage-name for ecr repository name, else name | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of first repository created |
| <a name="output_arn_map"></a> [arn\_map](#output\_arn\_map) | Map of repository names to repository ARNs |
| <a name="output_id"></a> [id](#output\_id) | Registry ID |
| <a name="output_name"></a> [name](#output\_name) | Name of first repository created |
| <a name="output_url"></a> [url](#output\_url) | URL of first repository created |
| <a name="output_url_map"></a> [url\_map](#output\_url\_map) | Map of repository names to repository URLs |
<!-- END_TF_DOCS -->