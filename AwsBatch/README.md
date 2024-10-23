# AWS Batch

This module creates and configures AWS Batch.

## Context

It uses the Label module to help ensure consistent naming conventions.
The module should access the whole context as `module.this.context` to get the input variables with nulls for defaults.
For example:

`context = module.this.context`

Access individual variables as `module.this.{var}`.

## Module Specs

[SPECS.md](./SPECS.md)
