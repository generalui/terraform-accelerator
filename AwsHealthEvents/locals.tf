locals {
  context        = module.this[var.event_rules[0].name]
  enabled        = local.context.enabled
  create_kms_key = local.enabled && var.kms_master_key_id == null
  event_rules    = { for event_rule in var.event_rules : event_rule.name => event_rule }
}
