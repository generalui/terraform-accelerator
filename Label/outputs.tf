output "id" {
  value       = module.label.id
  description = "Disambiguated ID string restricted to `id_length_limit` characters in total"
}

output "id_full" {
  value       = module.label.id_full
  description = "ID string not restricted in length"
}

output "enabled" {
  value       = module.label.enabled
  description = "True if module is enabled, false otherwise"
}

output "namespace" {
  value       = module.label.namespace
  description = "Normalized namespace"
}

output "tenant" {
  value       = module.label.tenant
  description = "Normalized tenant"
}

output "environment" {
  value       = module.label.environment
  description = "Normalized environment"
}

output "name" {
  value       = module.label.name
  description = "Normalized name"
}

output "stage" {
  value       = module.label.stage
  description = "Normalized stage"
}

output "delimiter" {
  value       = module.label.delimiter
  description = "Delimiter between `namespace`, `tenant`, `environment`, `stage`, `name` and `attributes`"
}

output "attributes" {
  value       = module.label.attributes
  description = "List of attributes"
}

output "tags" {
  value       = module.label.tags
  description = "Normalized Tag map"
}

output "additional_tag_map" {
  value       = module.label.additional_tag_map
  description = "The merged additional_tag_map"
}

output "label_order" {
  value       = module.label.label_order
  description = "The naming order actually used to create the ID"
}

output "regex_replace_chars" {
  value       = module.label.regex_replace_chars
  description = "The regex_replace_chars actually used to create the ID"
}

output "id_length_limit" {
  value       = module.label.id_length_limit
  description = "The id_length_limit actually used to create the ID, with `0` meaning unlimited"
}

output "tags_as_list_of_maps" {
  value       = module.label.tags_as_list_of_maps
  description = <<-EOT
    This is a list with one map for each `tag`. Each map contains the tag `key`,
    `value`, and contents of `var.additional_tag_map`. Used in the rare cases
    where resources need additional configuration information for each tag.
    EOT
}

output "descriptors" {
  value       = module.label.descriptors
  description = "Map of descriptors as configured by `descriptor_formats`"
}

output "normalized_context" {
  value       = module.label.normalized_context
  description = "Normalized context of this module"
}

output "context" {
  value       = module.label.context
  description = <<-EOT
  Merged but otherwise unmodified input to this module, to be used as context input to other modules.
  Note: this version will have null values as defaults, not the values actually used as defaults.
EOT
}
