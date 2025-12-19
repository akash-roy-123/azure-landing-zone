# Governance Module
# Azure Policy and Blueprints

# Note: Azure Policy and Blueprints require specific permissions
# This module provides structure for governance configurations

# Example: Resource Tagging Policy
resource "azurerm_policy_definition" "require_tags" {
  count        = var.enable_policy_assignments ? 1 : 0
  name         = "require-tags-${var.environment}"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require Tags on Resources"

  policy_rule = jsonencode({
    "if" = {
      "not" = {
        "field" = "[concat('tags[', parameters('tagName'), ']')]"
        "exists" = "true"
      }
    }
    "then" = {
      "effect" = "deny"
    }
  })

  parameters = jsonencode({
    "tagName" = {
      "type" = "String"
      "metadata" = {
        "displayName" = "Tag Name"
        "description" = "Name of the tag to require"
      }
    }
  })
}

# Policy Assignment (if management group is provided)
resource "azurerm_management_group_policy_assignment" "tags" {
  count                = var.enable_policy_assignments && var.management_group_id != "" ? 1 : 0
  name                 = "require-tags-assignment"
  management_group_id = var.management_group_id
  policy_definition_id = azurerm_policy_definition.require_tags[0].id

  parameters = jsonencode({
    "tagName" = {
      "value" = "Environment"
    }
  })
}

