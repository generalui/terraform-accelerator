# Terraform Accelerators

These modules are intended as "go to" terraform modules for building IAC.

## Requirements

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) configured with your credentials (~/.aws/credentials) - For AWS modules only
- [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) tool installed
  - This repo is set up to use [asdf](https://github.com/asdf-community/asdf-hashicorp)

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

For linting documentation, see [Documentation Linting](#documentation-linting).

## Validation

Before a PR to the main branch will be accepted, the code must pass validation.
To check if scripts are passing validation locally, simply execute the following from within the appropriate Terraform project folder:

```sh
terraform init && terraform validate
```

## Naming Conventions

Follow the Terraform "best practices" naming conventions here <https://www.terraform-best-practices.com/naming>.

For files, use "snake_case" for the main name of the file or folder. If the file is an "output", append "_output".

For folders, use "PascalCase".

## Development

Create a new branch off of `main`.

- Branches for new features should be named like `feature/cool_new_feature`.
- Branches for bug fixing should be named like `bugfix/pesky_bug`.
- Branches for other changes, like documentation, tooling, etc should be named with your initials, like `jmcr/docs`.

Make PRs to the `main` branch.

PRs to main will kick off the "Code Quality" Github workflow.
This will validate the terraform files as well as markdown files.
Merging should be denied if these fails.

The workflows use the `TERRAFORM_VERSION` variable for the repo (see <https://github.com/generalui/terraform-accelerator/settings/variables/actions>).
Ensure this value matches the version of Terraform being used to deploy.

## Documentation

To auto generate documentation, use [terraform-docs](https://github.com/terraform-docs/terraform-docs).

Generate the documentation to the `SPECS.md` file for the specific module.

Change directories to the module that needs documentation or a documentation update and run:

```sh
terraform-docs markdown table --output-file SPECS.md --output-mode inject ./
```

### Documentation Linting

Use the [`markdownlint` vscode extension](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint).

Or run in directly using [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2).

```sh
markdownlint-cli2 "**/*.md" "#**/SPECS.md" "#**/.terraform/**"
```

The [`.markdownlint.json`](./.markdownlint.json) file is used to configure the markdown linting rules.

The [`.markdownlintignore`](./.markdownlintignore) file is used to ignore linting for specific files and paths.

## Tagging

Once a new module is merged to `main`, create a new release tag with the version.
The version should be for that specific module, ie `1.0.1-KeyPair`.
Where `1.0.1` is the version and `-KeyPair` references the module name.
It is fine to have multiple release tags in the repo.

## Using Modules

The modules in this repo may be copied to another terraform project or may be referenced directly from Github and pinned to the version.
(See <https://developer.hashicorp.com/terraform/language/modules/sources#github>)

```hcl
source = "git::git@github.com:generalui/terraform-accelerator.git//KeyPair?ref=1.0.1-KeyPair"
```

Where `git::git@github.com:generalui/terraform-accelerator.git` references this repo,
`//KeyPair` references the folder that holds the module,
and `?ref=1.0.1-KeyPair` references the version.
