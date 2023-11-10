# AWS Security Group

This module creates a Security Group. See the [example](./example/).

Built from the Cloud Posse module, see more here: <https://registry.terraform.io/modules/cloudposse/security-group/aws/2.2.0>

## Broken

This module has been throwing this error:

```txt
Error: [WARN] A duplicate Security Group rule was found on (sg-06b87b47d908a08ae). This may be
│ a side effect of a now-fixed Terraform issue causing two security groups with
│ identical attributes but different source_security_group_ids to overwrite each
│ other in the state. See https://github.com/hashicorp/terraform/pull/2376 for more
│ information and instructions for recovery. Error: InvalidPermission.Duplicate: the specified rule "peer: 0.0.0.0/0, ALL, ALLOW" already exists
│       status code: 400, request id: c294554f-92aa-4238-acac-cc89e483c0fd
│
│   with module.security_group.module.security_group.aws_security_group_rule.keyed["all_egress"],
│   on .terraform/modules/security_group.security_group/main.tf line 196, in resource "aws_security_group_rule" "keyed":
│  196: resource "aws_security_group_rule" "keyed" {
```
