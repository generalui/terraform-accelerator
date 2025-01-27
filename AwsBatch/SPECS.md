<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.40 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | git::git@github.com:generalui/terraform-accelerator.git//Label | 1.0.1-Label |

## Resources

| Name | Type |
|------|------|
| [aws_batch_compute_environment.batch_compute_environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_compute_environment) | resource |
| [aws_batch_job_definition.batch_job_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_definition) | resource |
| [aws_batch_job_queue.batch_job_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_queue) | resource |
| [aws_cloudwatch_event_rule.batch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.batch_to_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.batch_event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_metric_filter.batch_failed_jobs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_log_resource_policy.batch_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_cloudwatch_metric_alarm.batch_failed_jobs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_instance_profile.batch_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.batch_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.batch_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.batch_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.batch_execution_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.batch_instance_role_ec2_container_policy_attachement](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.batch_service_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_strategy"></a> [allocation\_strategy](#input\_allocation\_strategy) | The allocation strategy to use for the compute resource in case not enough instances of the best fitting instance type can be allocated. This might be because of availability of the instance type in the region or Amazon EC2 service limits. For more information, see https://docs.aws.amazon.com/batch/latest/APIReference/API_ComputeResource.html#Batch-Type-ComputeResource-allocationStrategy | `string` | `"BEST_FIT"` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_batch_failed_alarm_actions"></a> [batch\_failed\_alarm\_actions](#input\_batch\_failed\_alarm\_actions) | List of SNS topic ARNs to notify on failure. | `list(string)` | `[]` | no |
| <a name="input_command"></a> [command](#input\_command) | Command to run on the container. | `list(string)` | <pre>[<br>  "python",<br>  "app.py"<br>]</pre> | no |
| <a name="input_container_mount_points"></a> [container\_mount\_points](#input\_container\_mount\_points) | Optional: List of container mount points. This parameter maps to Volumes in the Create a container section of the Docker Remote API (https://docs.docker.com/engine/api/v1.43/#tag/Container/operation/ContainerCreate) and the --volume option to docker run. | <pre>list(object({<br>    containerPath = optional(string)<br>    readOnly      = optional(bool)<br>    sourceVolume  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_container_volumes"></a> [container\_volumes](#input\_container\_volumes) | Optional: List of of data volumes used in a job. See https://docs.aws.amazon.com/batch/latest/APIReference/API_Volume.html for details. | <pre>list(object({<br>    efsVolumeConfiguration = optional(object({<br>      authorizationConfig = optional(object({<br>        accessPointId = optional(string)<br>        iam           = optional(string)<br>      }))<br>      fileSystemId          = string<br>      rootDirectory         = optional(string)<br>      transitEncryption     = optional(string)<br>      transitEncryptionPort = optional(number)<br>    }))<br>    host = optional(object({<br>      sourcePath = optional(string)<br>    }))<br>    name = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes and tags, which are merged. | `any` | <pre>{<br>  "attributes": [],<br>  "enabled": true,<br>  "name": null,<br>  "namespace": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_ecr_tag"></a> [ecr\_tag](#input\_ecr\_tag) | Optional: The version tag for the of the lambda ECR image to use. If not provided, be sure to set the lambda\_runtime instead. | `string` | n/a | yes |
| <a name="input_ecr_url"></a> [ecr\_url](#input\_ecr\_url) | Optional: Url for the ecr repository for the lambda ECR image. If not provided, be sure to set the lambda\_runtime instead. | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_launch_template_id"></a> [launch\_template\_id](#input\_launch\_template\_id) | The ID of the launch template. You must specify either the launch template ID or launch template name in the request, but not both. | `string` | `null` | no |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | Name of the launch template. You must specify either the launch template ID or launch template name in the request, but not both. | `string` | `null` | no |
| <a name="input_launch_template_version"></a> [launch\_template\_version](#input\_launch\_template\_version) | The version number of the launch template. Default: The default version of the launch template. | `string` | `null` | no |
| <a name="input_linux_parameters"></a> [linux\_parameters](#input\_linux\_parameters) | Linux-specific modifications that are applied to the container, such as details for device mappings. | <pre>object({<br>    devices = optional(list(object({<br>      hostPath      = string<br>      containerPath = optional(string)<br>      permissions   = optional(list(string))<br>    }))),<br>    initProcessEnabled = optional(bool)<br>    maxSwap            = optional(number)<br>    sharedMemorySize   = optional(number)<br>    swappiness         = optional(number)<br>    tmpfs = optional(list(object({<br>      containerPath = string<br>      mountOptions  = optional(list(string))<br>      size          = number<br>    })))<br>  })</pre> | `null` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | String to prefix AWS resource names. This will also be used for the event log group but will be prepended with /aws/events/. | `string` | n/a | yes |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Number of days to retain batch event logs for. Default: 30 | `number` | `30` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_propagate_tags_to_ecs_task"></a> [propagate\_tags\_to\_ecs\_task](#input\_propagate\_tags\_to\_ecs\_task) | Optional: Whether to propagate tags from the job definition to the ECS task or not. Defaults to true. | `bool` | `true` | no |
| <a name="input_resource_requirements"></a> [resource\_requirements](#input\_resource\_requirements) | The type and amount of a resource to assign to a container. The supported resources include GPU, MEMORY, and VCPU. See: https://docs.aws.amazon.com/batch/latest/APIReference/API_ResourceRequirement.html | `list(object({ type = string, value = string }))` | <pre>[<br>  {<br>    "type": "VCPU",<br>    "value": "1"<br>  },<br>  {<br>    "type": "MEMORY",<br>    "value": "512"<br>  }<br>]</pre> | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_worker_environment_variables"></a> [worker\_environment\_variables](#input\_worker\_environment\_variables) | Optional: Specify optional environment variables to pass to the worker. | `map(string)` | `{}` | no |
| <a name="input_worker_instance_types"></a> [worker\_instance\_types](#input\_worker\_instance\_types) | Optional: List of one or more valid EC2 instance types to use. example: ['m4.large'] | `set(string)` | <pre>[<br>  "m4.large"<br>]</pre> | no |
| <a name="input_worker_max_vcpus"></a> [worker\_max\_vcpus](#input\_worker\_max\_vcpus) | Optional: Max number of vcpus to run at the same time. Example: 16 | `number` | `16` | no |
| <a name="input_worker_min_vcpus"></a> [worker\_min\_vcpus](#input\_worker\_min\_vcpus) | Optional: Min number of vcpus to run at the same time. If 0, then there will be no EC2 instancse while idle. If > 0, then there will always be at least one hot instance ready to take jobs. Example: 0 | `number` | `0` | no |
| <a name="input_worker_security_group_ids"></a> [worker\_security\_group\_ids](#input\_worker\_security\_group\_ids) | Optional: example: [module.db\_security\_group.id] | `set(string)` | `[]` | no |
| <a name="input_worker_subnet_ids"></a> [worker\_subnet\_ids](#input\_worker\_subnet\_ids) | Optional: example: module.db\_subnets.private\_subnet\_ids | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_batch_instance_role"></a> [batch\_instance\_role](#output\_batch\_instance\_role) | The name of the batch instance role. |
| <a name="output_job_definition_arn"></a> [job\_definition\_arn](#output\_job\_definition\_arn) | The ARN of the job definition, includes revision (:#). |
| <a name="output_job_definition_arn_prefix"></a> [job\_definition\_arn\_prefix](#output\_job\_definition\_arn\_prefix) | The ARN of the job definition without the revision number. |
| <a name="output_job_definition_revision"></a> [job\_definition\_revision](#output\_job\_definition\_revision) | The revision of the job definition. |
| <a name="output_job_queue_arn"></a> [job\_queue\_arn](#output\_job\_queue\_arn) | The ARN of the job queue. |
<!-- END_TF_DOCS -->