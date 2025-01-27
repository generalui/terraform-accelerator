<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.71.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamic_subnets"></a> [dynamic\_subnets](#module\_dynamic\_subnets) | cloudposse/dynamic-subnets/aws | 2.4.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of Availability Zones (AZs) where subnets will be created. Ignored when `availability_zone_ids` is set.<br>The order of zones in the list ***must be stable*** or else Terraform will continually make changes.<br>If no AZs are specified, then `max_subnet_count` AZs will be selected in alphabetical order.<br>If `max_subnet_count > 0` and `length(var.availability_zones) > max_subnet_count`, the list<br>will be truncated. We recommend setting `availability_zones` and `max_subnet_count` explicitly as constant<br>(not computed) values for predictability, consistency, and stability. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_igw_id"></a> [igw\_id](#input\_igw\_id) | The Internet Gateway ID that the public subnets will route traffic to.<br>Used if `public_route_table_enabled` is `true`, ignored otherwise. | `list(string)` | `[]` | no |
| <a name="input_ipv4_cidr_block"></a> [ipv4\_cidr\_block](#input\_ipv4\_cidr\_block) | Base IPv4 CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`). Ignored if `ipv4_cidrs` is set.<br>If no CIDR block is provided, the VPC's default IPv4 CIDR block will be used. | `list(string)` | `[]` | no |
| <a name="input_max_subnet_count"></a> [max\_subnet\_count](#input\_max\_subnet\_count) | Sets the maximum number of each type (public or private) of subnet to deploy.<br>`0` will reserve a CIDR for every Availability Zone (excluding Local Zones) in the region, and<br>deploy a subnet in each availability zone specified in `availability_zones` or `availability_zone_ids`,<br>or every zone if none are specified. We recommend setting this equal to the maximum number of AZs you<br>anticipate using, to avoid causing subnets to be destroyed and recreated with smaller IPv4 CIDRs when AWS<br>adds an availability zone.<br>Due to Terraform limitations, you can not set `max_subnet_count` from a computed value, you have to set it<br>from an explicit constant. For most cases, `3` is a good choice. | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_nat_elastic_ips"></a> [nat\_elastic\_ips](#input\_nat\_elastic\_ips) | Existing Elastic IPs (not EIP IDs) to attach to the NAT Gateway(s) or Instance(s) instead of creating new ones. | `list(string)` | `[]` | no |
| <a name="input_nat_gateway_enabled"></a> [nat\_gateway\_enabled](#input\_nat\_gateway\_enabled) | Set `true` to create NAT Gateways to perform IPv4 NAT and NAT64 as needed.<br>Defaults to `true` unless `nat_instance_enabled` is `true`. | `bool` | `null` | no |
| <a name="input_nat_instance_enabled"></a> [nat\_instance\_enabled](#input\_nat\_instance\_enabled) | Set `true` to create NAT Instances to perform IPv4 NAT.<br>Defaults to `false`. | `bool` | `null` | no |
| <a name="input_private_subnets_enabled"></a> [private\_subnets\_enabled](#input\_private\_subnets\_enabled) | If false, do not create private subnets (or NAT gateways or instances) | `bool` | `true` | no |
| <a name="input_public_subnets_enabled"></a> [public\_subnets\_enabled](#input\_public\_subnets\_enabled) | If false, do not create public subnets.<br>Since NAT gateways and instances must be created in public subnets, these will also not be created when `false`. | `bool` | `true` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zone_ids"></a> [availability\_zone\_ids](#output\_availability\_zone\_ids) | List of Availability Zones IDs where subnets were created, when available |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | List of Availability Zones where subnets were created |
| <a name="output_az_private_route_table_ids_map"></a> [az\_private\_route\_table\_ids\_map](#output\_az\_private\_route\_table\_ids\_map) | Map of AZ names to list of private route table IDs in the AZs |
| <a name="output_az_private_subnets_map"></a> [az\_private\_subnets\_map](#output\_az\_private\_subnets\_map) | Map of AZ names to list of private subnet IDs in the AZs |
| <a name="output_az_public_route_table_ids_map"></a> [az\_public\_route\_table\_ids\_map](#output\_az\_public\_route\_table\_ids\_map) | Map of AZ names to list of public route table IDs in the AZs |
| <a name="output_az_public_subnets_map"></a> [az\_public\_subnets\_map](#output\_az\_public\_subnets\_map) | Map of AZ names to list of public subnet IDs in the AZs |
| <a name="output_named_private_route_table_ids_map"></a> [named\_private\_route\_table\_ids\_map](#output\_named\_private\_route\_table\_ids\_map) | Map of subnet names (specified in `subnets_per_az_names` variable) to lists of private route table IDs |
| <a name="output_named_private_subnets_map"></a> [named\_private\_subnets\_map](#output\_named\_private\_subnets\_map) | Map of subnet names (specified in `subnets_per_az_names` variable) to lists of private subnet IDs |
| <a name="output_named_private_subnets_stats_map"></a> [named\_private\_subnets\_stats\_map](#output\_named\_private\_subnets\_stats\_map) | Map of subnet names (specified in `subnets_per_az_names` variable) to lists of objects with each object having three items: AZ, private subnet ID, private route table ID |
| <a name="output_named_public_route_table_ids_map"></a> [named\_public\_route\_table\_ids\_map](#output\_named\_public\_route\_table\_ids\_map) | Map of subnet names (specified in `subnets_per_az_names` variable) to lists of public route table IDs |
| <a name="output_named_public_subnets_map"></a> [named\_public\_subnets\_map](#output\_named\_public\_subnets\_map) | Map of subnet names (specified in `subnets_per_az_names` variable) to lists of public subnet IDs |
| <a name="output_named_public_subnets_stats_map"></a> [named\_public\_subnets\_stats\_map](#output\_named\_public\_subnets\_stats\_map) | Map of subnet names (specified in `subnets_per_az_names` variable) to lists of objects with each object having three items: AZ, public subnet ID, public route table ID |
| <a name="output_nat_eip_allocation_ids"></a> [nat\_eip\_allocation\_ids](#output\_nat\_eip\_allocation\_ids) | Elastic IP allocations in use by NAT |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | IDs of the NAT Gateways created |
| <a name="output_nat_instance_ami_id"></a> [nat\_instance\_ami\_id](#output\_nat\_instance\_ami\_id) | ID of AMI used by NAT instance |
| <a name="output_nat_instance_ids"></a> [nat\_instance\_ids](#output\_nat\_instance\_ids) | IDs of the NAT Instances created |
| <a name="output_nat_ips"></a> [nat\_ips](#output\_nat\_ips) | Elastic IP Addresses in use by NAT |
| <a name="output_private_network_acl_id"></a> [private\_network\_acl\_id](#output\_private\_network\_acl\_id) | ID of the Network ACL created for private subnets |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | IDs of the created private route tables |
| <a name="output_private_subnet_arns"></a> [private\_subnet\_arns](#output\_private\_subnet\_arns) | ARNs of the created private subnets |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | IPv4 CIDR blocks of the created private subnets |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | IDs of the created private subnets |
| <a name="output_private_subnet_ipv6_cidrs"></a> [private\_subnet\_ipv6\_cidrs](#output\_private\_subnet\_ipv6\_cidrs) | IPv6 CIDR blocks of the created private subnets |
| <a name="output_public_network_acl_id"></a> [public\_network\_acl\_id](#output\_public\_network\_acl\_id) | ID of the Network ACL created for public subnets |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | IDs of the created public route tables |
| <a name="output_public_subnet_arns"></a> [public\_subnet\_arns](#output\_public\_subnet\_arns) | ARNs of the created public subnets |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | IPv4 CIDR blocks of the created public subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | IDs of the created public subnets |
| <a name="output_public_subnet_ipv6_cidrs"></a> [public\_subnet\_ipv6\_cidrs](#output\_public\_subnet\_ipv6\_cidrs) | IPv6 CIDR blocks of the created public subnets |
<!-- END_TF_DOCS -->