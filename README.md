# Terraform Accelerators

These modules are intended as "go to" terraform modules for building IAC.

## Requirements

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) configured with your credentials (~/.aws/credentials) - For AWS modules only
- [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) tool installed
  - This repo is set up to use [asdf](https://github.com/asdf-community/asdf-hashicorp)

## Usage

The modules in this repo may be copied to another terraform project or may be referenced directly from Github.
(See <https://developer.hashicorp.com/terraform/language/modules/sources#github>)

```hcl
source = "git::git@github.com:generalui/terraform-accelerator.git//IamRole?ref=1.0.0"
```

## Linting

Before a PR to the main branch will be accepted, the code must pass lint.
To check if scripts are passing lint locally, simply execute

```sh
terraform fmt -check -recursive -diff
```

To format and fix any linting issues, execute

```sh
terraform fmt -recursive
```
