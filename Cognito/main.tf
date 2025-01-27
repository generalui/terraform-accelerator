# AWS Cognito

resource "aws_cognito_user_pool" "pool" {
  count = local.enabled ? 1 : 0

  alias_attributes         = var.alias_attributes
  username_attributes      = var.username_attributes
  auto_verified_attributes = var.auto_verified_attributes

  name                       = local.user_pool_name
  email_verification_subject = var.email_verification_subject == "" || var.email_verification_subject == null ? var.admin_create_user_config_email_subject : var.email_verification_subject
  email_verification_message = var.email_verification_message == "" || var.email_verification_message == null ? var.admin_create_user_config_email_message : var.email_verification_message
  mfa_configuration          = var.mfa_configuration
  sms_authentication_message = var.sms_authentication_message
  sms_verification_message   = var.sms_verification_message
  deletion_protection        = var.deletion_protection

  dynamic "username_configuration" {
    for_each = local.username_configuration
    content {
      case_sensitive = lookup(username_configuration.value, "case_sensitive")
    }
  }

  dynamic "admin_create_user_config" {
    for_each = local.admin_create_user_config
    content {
      allow_admin_create_user_only = lookup(admin_create_user_config.value, "allow_admin_create_user_only")

      dynamic "invite_message_template" {
        for_each = lookup(admin_create_user_config.value, "email_message", null) == null && lookup(admin_create_user_config.value, "email_subject", null) == null && lookup(admin_create_user_config.value, "sms_message", null) == null ? [] : [1]
        content {
          email_message = lookup(admin_create_user_config.value, "email_message")
          email_subject = lookup(admin_create_user_config.value, "email_subject")
          sms_message   = lookup(admin_create_user_config.value, "sms_message")
        }
      }
    }
  }

  dynamic "device_configuration" {
    for_each = local.device_configuration
    content {
      challenge_required_on_new_device      = lookup(device_configuration.value, "challenge_required_on_new_device")
      device_only_remembered_on_user_prompt = lookup(device_configuration.value, "device_only_remembered_on_user_prompt")
    }
  }

  dynamic "email_configuration" {
    for_each = local.email_configuration
    content {
      reply_to_email_address = lookup(email_configuration.value, "reply_to_email_address")
      source_arn             = lookup(email_configuration.value, "source_arn")
      email_sending_account  = lookup(email_configuration.value, "email_sending_account")
      from_email_address     = lookup(email_configuration.value, "from_email_address")
    }
  }

  dynamic "lambda_config" {
    for_each = var.lambda_config == null && length(local.lambda_config) == 0 ? [] : local.lambda_config
    content {
      create_auth_challenge          = lookup(lambda_config.value, "create_auth_challenge")
      custom_message                 = lookup(lambda_config.value, "custom_message")
      define_auth_challenge          = lookup(lambda_config.value, "define_auth_challenge")
      post_authentication            = lookup(lambda_config.value, "post_authentication")
      post_confirmation              = lookup(lambda_config.value, "post_confirmation")
      pre_authentication             = lookup(lambda_config.value, "pre_authentication")
      pre_sign_up                    = lookup(lambda_config.value, "pre_sign_up")
      pre_token_generation           = lookup(lambda_config.value, "pre_token_generation")
      user_migration                 = lookup(lambda_config.value, "user_migration")
      verify_auth_challenge_response = lookup(lambda_config.value, "verify_auth_challenge_response")
      kms_key_id                     = lookup(lambda_config.value, "kms_key_id")
      dynamic "custom_email_sender" {
        for_each = length(lambda_config.value["custom_email_sender"]) == 0 ? [] : [1]
        content {
          lambda_arn     = lambda_config.value["custom_email_sender"]["lambda_arn"]
          lambda_version = lambda_config.value["custom_email_sender"]["lambda_version"]
        }
      }
      dynamic "custom_sms_sender" {
        for_each = length(lambda_config.value["custom_sms_sender"]) == 0 ? [] : [1]
        content {
          lambda_arn     = lambda_config.value["custom_sms_sender"]["lambda_arn"]
          lambda_version = lambda_config.value["custom_sms_sender"]["lambda_version"]
        }
      }
    }
  }

  dynamic "sms_configuration" {
    for_each = local.sms_configuration
    content {
      external_id    = lookup(sms_configuration.value, "external_id")
      sns_caller_arn = lookup(sms_configuration.value, "sns_caller_arn")
    }
  }

  dynamic "software_token_mfa_configuration" {
    for_each = local.software_token_mfa_configuration
    content {
      enabled = lookup(software_token_mfa_configuration.value, "enabled")
    }
  }

  dynamic "password_policy" {
    for_each = local.password_policy
    content {
      minimum_length                   = lookup(password_policy.value, "minimum_length")
      require_lowercase                = lookup(password_policy.value, "require_lowercase")
      require_numbers                  = lookup(password_policy.value, "require_numbers")
      require_symbols                  = lookup(password_policy.value, "require_symbols")
      require_uppercase                = lookup(password_policy.value, "require_uppercase")
      temporary_password_validity_days = lookup(password_policy.value, "temporary_password_validity_days")
    }
  }

  dynamic "schema" {
    for_each = var.schemas == null ? [] : var.schemas
    content {
      attribute_data_type      = lookup(schema.value, "attribute_data_type")
      developer_only_attribute = lookup(schema.value, "developer_only_attribute")
      mutable                  = lookup(schema.value, "mutable")
      name                     = lookup(schema.value, "name")
      required                 = lookup(schema.value, "required")
    }
  }

  dynamic "schema" {
    for_each = var.string_schemas == null ? [] : var.string_schemas
    content {
      attribute_data_type      = lookup(schema.value, "attribute_data_type")
      developer_only_attribute = lookup(schema.value, "developer_only_attribute")
      mutable                  = lookup(schema.value, "mutable")
      name                     = lookup(schema.value, "name")
      required                 = lookup(schema.value, "required")

      # string_attribute_constraints
      dynamic "string_attribute_constraints" {
        for_each = length(lookup(schema.value, "string_attribute_constraints")) == 0 ? [] : [lookup(schema.value, "string_attribute_constraints", {})]
        content {
          min_length = lookup(string_attribute_constraints.value, "min_length", 0)
          max_length = lookup(string_attribute_constraints.value, "max_length", 0)
        }
      }
    }
  }

  dynamic "schema" {
    for_each = var.number_schemas == null ? [] : var.number_schemas
    content {
      attribute_data_type      = lookup(schema.value, "attribute_data_type")
      developer_only_attribute = lookup(schema.value, "developer_only_attribute")
      mutable                  = lookup(schema.value, "mutable")
      name                     = lookup(schema.value, "name")
      required                 = lookup(schema.value, "required")

      # number_attribute_constraints
      dynamic "number_attribute_constraints" {
        for_each = length(lookup(schema.value, "number_attribute_constraints")) == 0 ? [] : [lookup(schema.value, "number_attribute_constraints", {})]
        content {
          min_value = lookup(number_attribute_constraints.value, "min_value", 0)
          max_value = lookup(number_attribute_constraints.value, "max_value", 0)
        }
      }
    }
  }

  dynamic "user_pool_add_ons" {
    for_each = local.user_pool_add_ons
    content {
      advanced_security_mode = lookup(user_pool_add_ons.value, "advanced_security_mode")
    }
  }

  dynamic "verification_message_template" {
    for_each = local.verification_message_template
    content {
      default_email_option  = lookup(verification_message_template.value, "default_email_option")
      email_message_by_link = lookup(verification_message_template.value, "email_message_by_link")
      email_subject_by_link = lookup(verification_message_template.value, "email_subject_by_link")
    }
  }

  dynamic "account_recovery_setting" {
    for_each = length(var.recovery_mechanisms) == 0 ? [] : [1]
    content {
      # recovery_mechanism
      dynamic "recovery_mechanism" {
        for_each = var.recovery_mechanisms
        content {
          name     = lookup(recovery_mechanism.value, "name")
          priority = lookup(recovery_mechanism.value, "priority")
        }
      }
    }
  }

  tags = module.this.tags
}
