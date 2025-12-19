output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.main.name
}

output "application_insights_id" {
  description = "Application Insights ID"
  value       = var.enable_insights ? azurerm_application_insights.main[0].id : null
}

output "dashboard_url" {
  description = "Azure Monitor dashboard URL"
  value       = "https://portal.azure.com/#@${data.azurerm_client_config.current.tenant_id}/resource${azurerm_log_analytics_workspace.main.id}"
}

