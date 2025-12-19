# Azure Landing Zone - Outputs

output "resource_group_name" {
  description = "Name of the landing zone resource group"
  value       = azurerm_resource_group.landing_zone.name
}

output "resource_group_id" {
  description = "ID of the landing zone resource group"
  value       = azurerm_resource_group.landing_zone.id
}

output "hub_network_id" {
  description = "ID of the hub virtual network"
  value       = module.hub_network.vnet_id
}

output "hub_network_name" {
  description = "Name of the hub virtual network"
  value       = module.hub_network.vnet_name
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = module.monitoring.log_analytics_workspace_id
}

output "key_vault_id" {
  description = "ID of the Azure Key Vault"
  value       = module.security.key_vault_id
}

output "key_vault_uri" {
  description = "URI of the Azure Key Vault"
  value       = module.security.key_vault_uri
}

output "spoke_network_ids" {
  description = "Map of spoke network IDs"
  value       = { for k, v in module.spoke_networks : k => v.vnet_id }
}

output "firewall_public_ip" {
  description = "Public IP address of Azure Firewall (if enabled)"
  value       = var.enable_azure_firewall ? module.hub_network.firewall_public_ip : null
}

output "monitoring_dashboard_url" {
  description = "URL to Azure Monitor dashboard"
  value       = module.monitoring.dashboard_url
}

