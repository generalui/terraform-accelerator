<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_health_events"></a> [health\_events](#module\_health\_events) | ../ | n/a |
| <a name="module_this"></a> [this](#module\_this) | git::git@github.com:generalui/terraform-accelerator.git//Label | 1.0.0-Label |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS profile name as set in the shared credentials file. | `string` | `"default"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region. | `string` | `"us-west-2"` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "enabled": true,<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Current environment, e.g. 'prod', 'staging', 'dev', 'QA', 'performance' | `string` | `"test"` | no |
| <a name="input_event_rules"></a> [event\_rules](#input\_event\_rules) | Event Rules | <pre>list(object({<br>    name        = string<br>    description = string<br>    event_rule_pattern = object({<br>      detail = object({<br>        service             = string<br>        event_type_category = string<br>        event_type_codes    = list(string)<br>      })<br>    })<br>  }))</pre> | <pre>[<br>  {<br>    "description": "EC2 Health Event — Scheduled Change",<br>    "event_rule_pattern": {<br>      "detail": {<br>        "event_type_category": "ScheduledChange",<br>        "event_type_codes": [<br>          "AWS_EC2_DEDICATED_HOST_ACCESSREVOKED_RETIREMENT_SCHEDULED",<br>          "AWS_EC2_DEDICATED_HOST_NETWORK_MAINTENANCE_SCHEDULED",<br>          "AWS_EC2_DEDICATED_HOST_POWER_MAINTENANCE_SCHEDULED",<br>          "AWS_EC2_DEDICATED_HOST_RETIREMENT_SCHEDULED",<br>          "AWS_EC2_INSTANCE_NETWORK_MAINTENANCE_SCHEDULED",<br>          "AWS_EC2_INSTANCE_POWER_MAINTENANCE_SCHEDULED",<br>          "AWS_EC2_INSTANCE_REBOOT_FLEXIBLE_MAINTENANCE_SCHEDULED",<br>          "AWS_EC2_INSTANCE_REBOOT_MAINTENANCE_SCHEDULED",<br>          "AWS_EC2_INSTANCE_RETIREMENT_EXPEDITED",<br>          "AWS_EC2_INSTANCE_RETIREMENT_SCHEDULED",<br>          "AWS_EC2_INSTANCE_STOP_SCHEDULED",<br>          "AWS_EC2_INSTANCE_TERMINATION_SCHEDULED",<br>          "AWS_EC2_PERSISTENT_INSTANCE_POWER_MAINTENANCE_SCHEDULED",<br>          "AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_EXPEDITED",<br>          "AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_SCHEDULED",<br>          "AWS_EC2_SYSTEM_REBOOT_MAINTENANCE_SCHEDULED"<br>        ],<br>        "service": "EC2"<br>      }<br>    },<br>    "name": "ec2-scheduled-changes"<br>  },<br>  {<br>    "description": "EC2 Health Event — Issue",<br>    "event_rule_pattern": {<br>      "detail": {<br>        "event_type_category": "Issue",<br>        "event_type_codes": [<br>          "AWS_EC2_NETWORK_CONNECTIVITY_ISSUE",<br>          "AWS_EC2_INSTANCE_STORE_DRIVE_PERFORMANCE_DEGRADED"<br>        ],<br>        "service": "EC2"<br>      }<br>    },<br>    "name": "ec2-issue"<br>  }<br>]</pre> | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `"xmpl"` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of the project as a whole | `string` | `"HealthEvents"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->