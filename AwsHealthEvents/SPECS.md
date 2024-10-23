<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_kms_key"></a> [sns\_kms\_key](#module\_sns\_kms\_key) | git::git@github.com:generalui/terraform-accelerator.git//KmsKey | 1.0.0-KmsKey |
| <a name="module_sns_topic"></a> [sns\_topic](#module\_sns\_topic) | cloudposse/sns-topic/aws | 0.20.1 |
| <a name="module_this"></a> [this](#module\_this) | git::git@github.com:generalui/terraform-accelerator.git//Label | 1.0.0-Label |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.health_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_kms_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes and tags, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "enabled": true,<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_event_rules"></a> [event\_rules](#input\_event\_rules) | A list of Event Rules to use when creating EventBridge Rules for the AWS Personal Health Service.<br><br>name:<br>  The base name of the Event Rule (final name will be used in tandem with context attributes)<br>description:<br>  The description to use for the Event Rule<br>event\_rule\_pattern:<br>  The Event Rule Pattern to use when creating the Event Rule.<br>  For more information, see: https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-events.html | <pre>list(object({<br>    name        = string<br>    description = string<br>    event_rule_pattern = object({<br>      detail = object({<br>        service             = string<br>        event_type_category = string<br>        event_type_codes    = list(string)<br>      })<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | The ID or alias of the customer master key (CMK) to use for encrypting the Amazon SNS topic.<br>  The CMK must have its resource-based policy allow the service `cloudwatch.amazonaws.com` to perform `kms:Decrypt` and `kms:GenerateDataKey` on it.<br>  If this variable is not supplied, a CMK with the sufficient resource-based policy will be created and used when configuring encryption for the SNS topic. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subscribers"></a> [subscribers](#input\_subscribers) | Required configuration for subscribers to SNS topic. | <pre>map(object({<br>    # The protocol to use. The possible values for this are: email, sqs, sms, lambda, application. (http or https are partially supported, see below).<br>    protocol = string<br>    # The endpoint to send data to, the contents will vary with the protocol. (see below for more information)<br>    endpoint = string<br>    # Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty (default is false)<br>    endpoint_auto_confirms = bool<br>    # Boolean indicating whether or not to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property) (default is false)<br>    raw_message_delivery = bool<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_event_rule_arns"></a> [event\_rule\_arns](#output\_event\_rule\_arns) | The ARNs of the created EventBridge Rules. |
| <a name="output_event_rule_names"></a> [event\_rule\_names](#output\_event\_rule\_names) | The names of the created EventBridge Rules. |
<!-- END_TF_DOCS -->