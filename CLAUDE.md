# CLAUDE.md — AI Assistant Context

This file provides context for AI coding assistants (Claude, Cursor, GitHub Copilot).

## What This Repository Is

A mono-repo of reusable Terraform modules for building AWS infrastructure at GenUI.
Each top-level directory is a self-contained Terraform module (e.g. `VPC/`, `RDS/`, `ECR/`).

Consumers reference modules via:

```hcl
module "vpc" {
  source  = "github.com/generalui/terraform-accelerator//VPC?ref={version-tag}"
  # ...
}
```

## Repository Structure

```text
{ModuleName}/
  main.tf          # Module resources
  variables.tf     # Input variables
  outputs.tf       # Output values
  project.json     # Version — MUST be bumped on every change to this module
  README.md        # Module documentation
.github/
  workflows/
    code-quality.yml   # PR gate: markdownlint + terraform fmt/validate
    create-release.yml # Auto-releases on merge to main
.tool-versions         # asdf version pins
CLAUDE.md              # This file
README.md              # Repo overview
```

## Critical: Versioning Contract

**Every change to a module requires a `project.json` version bump. No exceptions.**

- Patch (1.0.0 → 1.0.1): bug fixes, variable description updates, documentation
- Minor (1.0.0 → 1.1.0): new optional variables, backwards-compatible additions
- Major (1.0.0 → 2.0.0): breaking changes to variable names, types, or required inputs

Skipping the version bump will cause `create-release.yml` to fail on merge to `main`
with a "tag already exists" error.

## CI Workflows

**`code-quality.yml`** (PR gate) — runs on PRs to `main`:

- Markdownlint: fires when any `**/*.md` file changes
- Terraform lint: `terraform fmt -check -recursive` fires when any `**/*.tf` file changes
- Version check: verifies `project.json` version tag doesn't already exist

**`create-release.yml`** (release) — runs on push to `main`:

- Reads `project.json` from each changed module directory
- Creates tag `{version}-{ModuleName}` and GitHub Release per changed module

## Conventions

- Each module is a standalone, reusable Terraform root module
- All variables documented with `description`
- All outputs documented with `description`
- Tag all resources: use a `tags` variable merged with module-specific tags
- `terraform fmt -recursive` must pass before committing
- `terraform validate` should pass (requires `terraform init` first)
- New modules start at version `1.0.0` in `project.json`

## Adding a New Module

1. Create `{ModuleName}/` directory
2. Add `main.tf`, `variables.tf`, `outputs.tf`
3. Add `project.json` with `{"version": "1.0.0"}`
4. Add `README.md` documenting inputs, outputs, and example usage
5. Run `terraform fmt -recursive`

## Never

- Hardcode AWS account IDs, regions, or secrets in module code
- Commit `.terraform/`, `*.tfstate`, or `*.tfstate.backup`
- Merge to `main` without bumping `project.json`
