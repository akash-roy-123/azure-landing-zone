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

variable "spoke_name" {
  description = "Name of the spoke network"
  type        = string
}

variable "address_space" {
  description = "Address space for spoke network"
  type        = list(string)
}

variable "hub_vnet_id" {
  description = "Hub virtual network ID"
  type        = string
}

variable "hub_resource_id" {
  description = "Hub resource ID"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

