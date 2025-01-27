locals {
  identity_pool_name = coalesce(var.identity_pool_name, module.this.id)
  identity_pool_cognito_identity_providers = setunion(
    var.identity_pool_cognito_identity_providers,
    [{
      client_id               = aws_cognito_user_pool_client.client[0].id
      provider_name           = aws_cognito_user_pool.pool[0].endpoint
      server_side_token_check = true
    }]
  )
}


resource "aws_cognito_identity_pool" "main" {
  count = local.enabled ? 1 : 0

  identity_pool_name               = local.identity_pool_name
  allow_unauthenticated_identities = var.identity_pool_allow_unauthenticated_identities
  developer_provider_name          = var.identity_pool_developer_provider_name
  openid_connect_provider_arns     = var.identity_pool_oidc_provider_arns
  saml_provider_arns               = var.identity_pool_saml_provider_arns
  supported_login_providers        = var.identity_pool_supported_login_providers

  dynamic "cognito_identity_providers" {
    for_each = local.identity_pool_cognito_identity_providers

    content {
      client_id               = lookup(cognito_identity_providers.value, "client_id", null)
      provider_name           = lookup(cognito_identity_providers.value, "provider_name", null)
      server_side_token_check = lookup(cognito_identity_providers.value, "server_side_token_check", null)
    }
  }

  tags = module.this.tags
}
