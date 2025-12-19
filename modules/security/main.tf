# Security Module
# Azure Key Vault and security configurations

resource "azurerm_key_vault" "main" {
  count                       = var.enable_key_vault ? 1 : 0
  name                        = "kv-${var.organization_name}-${var.environment}-${substr(var.location, 0, 5)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  enabled_for_disk_encryption = true
  enabled_for_deployment     = true
  enabled_for_template_deployment = true
  purge_protection_enabled    = false
  soft_delete_retention_days  = 7

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = [] # Add allowed IPs if needed
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Update", "Recover", "Backup", "Restore"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
    ]

    certificate_permissions = [
      "Get", "List", "Create", "Delete", "Update", "Recover", "Backup", "Restore"
    ]
  }

  tags = var.common_tags
}

resource "azurerm_ddos_protection_plan" "main" {
  count               = var.enable_ddos ? 1 : 0
  name                = "ddos-${var.organization_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.common_tags
}

