output "managed_identity_id" {
  description = "Managed identity ID"
  value       = var.enable_managed_identities ? azurerm_user_assigned_identity.main[0].id : null
}

output "managed_identity_principal_id" {
  description = "Managed identity principal ID"
  value       = var.enable_managed_identities ? azurerm_user_assigned_identity.main[0].principal_id : null
}

