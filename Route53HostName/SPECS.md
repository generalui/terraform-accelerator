<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_route53_hostname"></a> [route53\_hostname](#module\_route53\_hostname) | cloudposse/route53-cluster-hostname/aws | 0.13.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | The name of the DNS record | `string` | `""` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_private_zone"></a> [private\_zone](#input\_private\_zone) | Used with `zone_name` input to get a private Hosted Zone. | `bool` | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | DNS records to create | `list(string)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | The TTL of the record to add to the DNS zone to complete certificate validation | `number` | `300` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of DNS records to create | `string` | `"CNAME"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 DNS Zone ID | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The Hosted Zone name of the desired Hosted Zone. | `string` | `null` | no |
| <a name="input_zone_tags"></a> [zone\_tags](#input\_zone\_tags) | Used with `zone_name` input. A map of tags, each pair of which must exactly match a pair on the desired Hosted Zone. | `map(string)` | `null` | no |
| <a name="input_zone_vpc_id"></a> [zone\_vpc\_id](#input\_zone\_vpc\_id) | Used with `zone_name` input to get a private Hosted Zone associated with the `vpc_id` (in this case, private\_zone is not mandatory). | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | DNS hostname |
<!-- END_TF_DOCS -->