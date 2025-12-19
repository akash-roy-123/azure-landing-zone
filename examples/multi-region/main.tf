# Multi-Region Azure Landing Zone Example
# Production-ready configuration with multiple regions

module "landing_zone_primary" {
  source = "../../"

  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  location          = "eastus"
  environment       = "production"
  organization_name = var.organization_name

  hub_address_space = ["10.0.0.0/16"]

  spoke_networks = {
    "spoke-app" = {
      address_space = ["10.1.0.0/16"]
    }
    "spoke-data" = {
      address_space = ["10.2.0.0/16"]
    }
  }

  enable_azure_firewall      = true
  enable_key_vault           = true
  enable_application_insights = true
  enable_policy_assignments  = true
  enable_ddos_protection     = true

  common_tags = {
    Environment = "production"
    Region      = "eastus"
    ManagedBy   = "Terraform"
  }
}

module "landing_zone_secondary" {
  source = "../../"

  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  location          = "westus"
  environment       = "production"
  organization_name = var.organization_name

  hub_address_space = ["10.10.0.0/16"]

  enable_azure_firewall      = true
  enable_key_vault           = true
  enable_application_insights = true

  common_tags = {
    Environment = "production"
    Region      = "westus"
    ManagedBy   = "Terraform"
  }
}

