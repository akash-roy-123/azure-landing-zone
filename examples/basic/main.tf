# Basic Azure Landing Zone Example
# Minimal configuration for quick start

module "landing_zone" {
  source = "../../"

  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  location          = "eastus"
  environment       = "development"
  organization_name = "contoso"

  hub_address_space = ["10.0.0.0/16"]

  # Enable core features
  enable_azure_firewall      = true
  enable_key_vault           = true
  enable_application_insights = true

  # Disable advanced features for basic setup
  enable_vpn_gateway        = false
  enable_ddos_protection     = false
  enable_blueprints          = false

  common_tags = {
    Environment = "development"
    Project     = "Basic Landing Zone"
    ManagedBy   = "Terraform"
  }
}

