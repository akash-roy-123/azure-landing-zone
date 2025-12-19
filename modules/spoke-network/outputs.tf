output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.spoke.id
}

output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.spoke.name
}

output "workload_subnet_id" {
  description = "Workload subnet ID"
  value       = azurerm_subnet.workload.id
}

output "app_subnet_id" {
  description = "Application subnet ID"
  value       = azurerm_subnet.app.id
}

output "data_subnet_id" {
  description = "Data subnet ID"
  value       = azurerm_subnet.data.id
}

