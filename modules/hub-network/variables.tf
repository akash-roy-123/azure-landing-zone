variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "organization_name" {
  description = "Organization identifier"
  type        = string
}

variable "hub_address_space" {
  description = "Address space for hub network"
  type        = list(string)
}

variable "enable_firewall" {
  description = "Enable Azure Firewall"
  type        = bool
  default     = true
}

variable "enable_vpn" {
  description = "Enable VPN Gateway"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

