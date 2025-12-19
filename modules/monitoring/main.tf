# Monitoring Module
# Log Analytics Workspace and Application Insights

resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-${var.organization_name}-${var.environment}-${substr(var.location, 0, 5)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days

  tags = var.common_tags
}

resource "azurerm_application_insights" "main" {
  count               = var.enable_insights ? 1 : 0
  name                = "appi-${var.organization_name}-${var.environment}-${substr(var.location, 0, 5)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.main.id

  tags = var.common_tags
}

resource "azurerm_monitor_action_group" "main" {
  name                = "ag-${var.organization_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  short_name          = "alerts"

  email_receiver {
    name          = "devops-team"
    email_address = "devops@example.com"
  }

  tags = var.common_tags
}

