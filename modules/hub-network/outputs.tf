output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.hub.id
}

output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.hub.name
}

output "resource_id" {
  description = "Resource ID"
  value       = azurerm_virtual_network.hub.id
}

output "firewall_public_ip" {
  description = "Firewall public IP address"
  value       = var.enable_firewall ? azurerm_public_ip.firewall[0].ip_address : null
}

output "firewall_private_ip" {
  description = "Firewall private IP address"
  value       = var.enable_firewall ? azurerm_firewall.hub[0].ip_configuration[0].private_ip_address : null
}

