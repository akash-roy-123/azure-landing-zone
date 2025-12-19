output "key_vault_id" {
  description = "Key Vault ID"
  value       = var.enable_key_vault ? azurerm_key_vault.main[0].id : null
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = var.enable_key_vault ? azurerm_key_vault.main[0].vault_uri : null
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = var.enable_key_vault ? azurerm_key_vault.main[0].name : null
}

