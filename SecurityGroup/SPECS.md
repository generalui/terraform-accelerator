<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.29 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | 5.1.0 |
| <a name="module_this"></a> [this](#module\_this) | git::git@github.com:generalui/terraform-accelerator.git//Label | 1.0.1-Label |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_computed_egress_rules"></a> [computed\_egress\_rules](#input\_computed\_egress\_rules) | List of computed egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_computed_egress_with_cidr_blocks"></a> [computed\_egress\_with\_cidr\_blocks](#input\_computed\_egress\_with\_cidr\_blocks) | List of computed egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_ipv6_cidr_blocks"></a> [computed\_egress\_with\_ipv6\_cidr\_blocks](#input\_computed\_egress\_with\_ipv6\_cidr\_blocks) | List of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_prefix_list_ids"></a> [computed\_egress\_with\_prefix\_list\_ids](#input\_computed\_egress\_with\_prefix\_list\_ids) | List of computed egress rules to create where 'prefix\_list\_ids' is used only | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_self"></a> [computed\_egress\_with\_self](#input\_computed\_egress\_with\_self) | List of computed egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_source_security_group_id"></a> [computed\_egress\_with\_source\_security\_group\_id](#input\_computed\_egress\_with\_source\_security\_group\_id) | List of computed egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_rules"></a> [computed\_ingress\_rules](#input\_computed\_ingress\_rules) | List of computed ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_computed_ingress_with_cidr_blocks"></a> [computed\_ingress\_with\_cidr\_blocks](#input\_computed\_ingress\_with\_cidr\_blocks) | List of computed ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_ipv6_cidr_blocks"></a> [computed\_ingress\_with\_ipv6\_cidr\_blocks](#input\_computed\_ingress\_with\_ipv6\_cidr\_blocks) | List of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_prefix_list_ids"></a> [computed\_ingress\_with\_prefix\_list\_ids](#input\_computed\_ingress\_with\_prefix\_list\_ids) | List of computed ingress rules to create where 'prefix\_list\_ids' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_self"></a> [computed\_ingress\_with\_self](#input\_computed\_ingress\_with\_self) | List of computed ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_source_security_group_id"></a> [computed\_ingress\_with\_source\_security\_group\_id](#input\_computed\_ingress\_with\_source\_security\_group\_id) | List of computed ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes and tags, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "enabled": true,<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_create_sg"></a> [create\_sg](#input\_create\_sg) | Whether to create security group | `bool` | `true` | no |
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | Time to wait for a security group to be created | `string` | `"10m"` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | Time to wait for a security group to be deleted | `string` | `"15m"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of security group | `string` | `"Security Group managed by Terraform"` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all egress rules | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_ipv6_cidr_blocks"></a> [egress\_ipv6\_cidr\_blocks](#input\_egress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to use on all egress rules | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_egress_prefix_list_ids"></a> [egress\_prefix\_list\_ids](#input\_egress\_prefix\_list\_ids) | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | `list(string)` | `[]` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_egress_with_cidr_blocks"></a> [egress\_with\_cidr\_blocks](#input\_egress\_with\_cidr\_blocks) | List of egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_ipv6_cidr_blocks"></a> [egress\_with\_ipv6\_cidr\_blocks](#input\_egress\_with\_ipv6\_cidr\_blocks) | List of egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_prefix_list_ids"></a> [egress\_with\_prefix\_list\_ids](#input\_egress\_with\_prefix\_list\_ids) | List of egress rules to create where 'prefix\_list\_ids' is used only | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_self"></a> [egress\_with\_self](#input\_egress\_with\_self) | List of egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_source_security_group_id"></a> [egress\_with\_source\_security\_group\_id](#input\_egress\_with\_source\_security\_group\_id) | List of egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_ipv6_cidr_blocks"></a> [ingress\_ipv6\_cidr\_blocks](#input\_ingress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_prefix_list_ids"></a> [ingress\_prefix\_list\_ids](#input\_ingress\_prefix\_list\_ids) | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_ingress_with_cidr_blocks"></a> [ingress\_with\_cidr\_blocks](#input\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_ipv6_cidr_blocks"></a> [ingress\_with\_ipv6\_cidr\_blocks](#input\_ingress\_with\_ipv6\_cidr\_blocks) | List of ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_prefix_list_ids"></a> [ingress\_with\_prefix\_list\_ids](#input\_ingress\_with\_prefix\_list\_ids) | List of ingress rules to create where 'prefix\_list\_ids' is used only | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_self"></a> [ingress\_with\_self](#input\_ingress\_with\_self) | List of ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_source_security_group_id"></a> [ingress\_with\_source\_security\_group\_id](#input\_ingress\_with\_source\_security\_group\_id) | List of ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_number_of_computed_egress_rules"></a> [number\_of\_computed\_egress\_rules](#input\_number\_of\_computed\_egress\_rules) | Number of computed egress rules to create by name | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_cidr_blocks"></a> [number\_of\_computed\_egress\_with\_cidr\_blocks](#input\_number\_of\_computed\_egress\_with\_cidr\_blocks) | Number of computed egress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_ipv6_cidr_blocks"></a> [number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks) | Number of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_prefix_list_ids"></a> [number\_of\_computed\_egress\_with\_prefix\_list\_ids](#input\_number\_of\_computed\_egress\_with\_prefix\_list\_ids) | Number of computed egress rules to create where 'prefix\_list\_ids' is used only | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_self"></a> [number\_of\_computed\_egress\_with\_self](#input\_number\_of\_computed\_egress\_with\_self) | Number of computed egress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_source_security_group_id"></a> [number\_of\_computed\_egress\_with\_source\_security\_group\_id](#input\_number\_of\_computed\_egress\_with\_source\_security\_group\_id) | Number of computed egress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_rules"></a> [number\_of\_computed\_ingress\_rules](#input\_number\_of\_computed\_ingress\_rules) | Number of computed ingress rules to create by name | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_cidr_blocks"></a> [number\_of\_computed\_ingress\_with\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_with\_cidr\_blocks) | Number of computed ingress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_ipv6_cidr_blocks"></a> [number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks) | Number of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_prefix_list_ids"></a> [number\_of\_computed\_ingress\_with\_prefix\_list\_ids](#input\_number\_of\_computed\_ingress\_with\_prefix\_list\_ids) | Number of computed ingress rules to create where 'prefix\_list\_ids' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_self"></a> [number\_of\_computed\_ingress\_with\_self](#input\_number\_of\_computed\_ingress\_with\_self) | Number of computed ingress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_source_security_group_id"></a> [number\_of\_computed\_ingress\_with\_source\_security\_group\_id](#input\_number\_of\_computed\_ingress\_with\_source\_security\_group\_id) | Number of computed ingress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| <a name="input_putin_khuylo"></a> [putin\_khuylo](#input\_putin\_khuylo) | Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo! | `bool` | `true` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR. | `bool` | `false` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | ID of existing security group whose rules we will manage | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Whether to use name\_prefix or fixed name. Should be true to able to update security group name after initial creation | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the security group |
| <a name="output_description"></a> [description](#output\_description) | The description of the security group |
| <a name="output_id"></a> [id](#output\_id) | The ID of the security group |
| <a name="output_name"></a> [name](#output\_name) | The name of the security group |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The owner ID |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID |
<!-- END_TF_DOCS -->