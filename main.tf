# Azure Landing Zone - Main Configuration
# Following Cloud Adoption Framework (CAF) best practices

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    # Backend configuration should be provided via backend config file
    # Example: terraform init -backend-config=backend.hcl
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

# Data sources
data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

# Resource Group for Landing Zone
resource "azurerm_resource_group" "landing_zone" {
  name     = "rg-${var.organization_name}-${var.environment}-${var.location}"
  location = var.location

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Purpose     = "Azure Landing Zone"
    }
  )
}

# Hub Network Module
module "hub_network" {
  source = "./modules/hub-network"

  resource_group_name = azurerm_resource_group.landing_zone.name
  location            = var.location
  environment         = var.environment
  organization_name   = var.organization_name

  hub_address_space = var.hub_address_space
  enable_firewall  = var.enable_azure_firewall
  enable_vpn       = var.enable_vpn_gateway

  common_tags = var.common_tags
}

# Identity Module
module "identity" {
  source = "./modules/identity"

  resource_group_name = azurerm_resource_group.landing_zone.name
  resource_group_id   = azurerm_resource_group.landing_zone.id
  location            = var.location
  environment         = var.environment
  organization_name   = var.organization_name

  enable_managed_identities = var.enable_managed_identities
  enable_rbac              = var.enable_rbac
  object_id                = data.azurerm_client_config.current.object_id

  common_tags = var.common_tags
}

# Governance Module
module "governance" {
  source = "./modules/governance"

  subscription_id    = data.azurerm_subscription.current.id
  management_group_id = var.management_group_id
  environment        = var.environment
  organization_name  = var.organization_name

  enable_policy_assignments = var.enable_policy_assignments
  enable_blueprints        = var.enable_blueprints

  common_tags = var.common_tags
}

# Monitoring Module
module "monitoring" {
  source = "./modules/monitoring"

  resource_group_name = azurerm_resource_group.landing_zone.name
  location            = var.location
  environment         = var.environment
  organization_name   = var.organization_name

  log_retention_days = var.log_retention_days
  enable_insights    = var.enable_application_insights

  common_tags = var.common_tags
}

# Security Module
module "security" {
  source = "./modules/security"

  resource_group_name = azurerm_resource_group.landing_zone.name
  location            = var.location
  environment         = var.environment
  organization_name   = var.organization_name

  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  enable_key_vault    = var.enable_key_vault
  enable_ddos         = var.enable_ddos_protection

  common_tags = var.common_tags
}

# Spoke Networks (if configured)
module "spoke_networks" {
  source   = "./modules/spoke-network"
  for_each = var.spoke_networks

  resource_group_name = azurerm_resource_group.landing_zone.name
  location            = var.location
  environment         = var.environment
  organization_name   = var.organization_name

  spoke_name        = each.key
  address_space     = each.value.address_space
  hub_vnet_id      = module.hub_network.vnet_id
  hub_resource_id  = module.hub_network.resource_id

  common_tags = var.common_tags
}

