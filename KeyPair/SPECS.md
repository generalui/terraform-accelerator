<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.2.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_pair"></a> [key\_pair](#module\_key\_pair) | cloudposse/key-pair/aws | 0.20.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_generate_ssh_key"></a> [generate\_ssh\_key](#input\_generate\_ssh\_key) | If set to `true`, new SSH key pair will be created and `ssh_public_key_file` will be ignored | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_private_key_extension"></a> [private\_key\_extension](#input\_private\_key\_extension) | Private key extension | `string` | `""` | no |
| <a name="input_public_key_extension"></a> [public\_key\_extension](#input\_public\_key\_extension) | Public key extension | `string` | `".pub"` | no |
| <a name="input_ssh_key_algorithm"></a> [ssh\_key\_algorithm](#input\_ssh\_key\_algorithm) | SSH key algorithm | `string` | `"RSA"` | no |
| <a name="input_ssh_public_key_file"></a> [ssh\_public\_key\_file](#input\_ssh\_public\_key\_file) | Name of existing SSH public key file (e.g. `id_rsa.pub`) | `string` | `null` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | Path to SSH public key directory (e.g. `/secrets`) | `string` | n/a | yes |
| <a name="input_ssm_parameter_enabled"></a> [ssm\_parameter\_enabled](#input\_ssm\_parameter\_enabled) | Whether an SSM parameter store value is created to store the key's private key pem. | `bool` | `false` | no |
| <a name="input_ssm_parameter_path_prefix"></a> [ssm\_parameter\_path\_prefix](#input\_ssm\_parameter\_path\_prefix) | The path prefix for the created SSM parameter e.g. '/ec2/key-pairs/acme-ue1-dev-bastion'. `ssm_parameter_enabled` must be set to `true` for this to take affect. | `string` | `"/ec2/key-pairs/"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | Name of SSH key |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | Content of the generated private key |
| <a name="output_private_key_filename"></a> [private\_key\_filename](#output\_private\_key\_filename) | Private Key Filename |
| <a name="output_public_key"></a> [public\_key](#output\_public\_key) | Content of the generated public key |
| <a name="output_public_key_filename"></a> [public\_key\_filename](#output\_public\_key\_filename) | Public Key Filename |
<!-- END_TF_DOCS -->