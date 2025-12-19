# Azure Landing Zone - Variables

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "location" {
  description = "Primary Azure region for deployment"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name (production, staging, development)"
  type        = string
  validation {
    condition     = contains(["production", "staging", "development"], var.environment)
    error_message = "Environment must be one of: production, staging, development"
  }
}

variable "organization_name" {
  description = "Organization identifier for resource naming"
  type        = string
}

variable "hub_address_space" {
  description = "Address space for hub virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "spoke_networks" {
  description = "Map of spoke networks to create"
  type = map(object({
    address_space = list(string)
  }))
  default = {}
}

variable "enable_azure_firewall" {
  description = "Enable Azure Firewall in hub network"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway in hub network"
  type        = bool
  default     = false
}

variable "enable_managed_identities" {
  description = "Enable managed identities for resources"
  type        = bool
  default     = true
}

variable "enable_rbac" {
  description = "Enable Role-Based Access Control"
  type        = bool
  default     = true
}

variable "enable_policy_assignments" {
  description = "Enable Azure Policy assignments"
  type        = bool
  default     = true
}

variable "enable_blueprints" {
  description = "Enable Azure Blueprints"
  type        = bool
  default     = false
}

variable "enable_key_vault" {
  description = "Enable Azure Key Vault"
  type        = bool
  default     = true
}

variable "enable_ddos_protection" {
  description = "Enable DDoS Protection Standard"
  type        = bool
  default     = false
}

variable "enable_application_insights" {
  description = "Enable Application Insights"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Log Analytics workspace retention in days"
  type        = number
  default     = 30
}

variable "management_group_id" {
  description = "Management Group ID for governance"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "Azure Landing Zone"
  }
}

variable "enable_multi_region" {
  description = "Enable multi-region deployment"
  type        = bool
  default     = false
}

variable "secondary_location" {
  description = "Secondary Azure region for multi-region deployment"
  type        = string
  default     = ""
}

