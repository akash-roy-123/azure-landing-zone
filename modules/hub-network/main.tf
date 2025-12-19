# Hub Network Module
# Central networking hub with Azure Firewall and shared services

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-${var.organization_name}-${var.environment}-hub-${substr(var.location, 0, 5)}"
  address_space       = var.hub_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.common_tags
}

resource "azurerm_subnet" "firewall" {
  count                = var.enable_firewall ? 1 : 0
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [cidrsubnet(var.hub_address_space[0], 8, 0)]
}

resource "azurerm_subnet" "gateway" {
  count                = var.enable_vpn ? 1 : 0
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [cidrsubnet(var.hub_address_space[0], 8, 1)]
}

resource "azurerm_subnet" "shared_services" {
  name                 = "snet-shared-services"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [cidrsubnet(var.hub_address_space[0], 8, 2)]
}

resource "azurerm_public_ip" "firewall" {
  count               = var.enable_firewall ? 1 : 0
  name                = "pip-${var.organization_name}-${var.environment}-fw-${substr(var.location, 0, 5)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.common_tags
}

resource "azurerm_firewall" "hub" {
  count               = var.enable_firewall ? 1 : 0
  name                = "fw-${var.organization_name}-${var.environment}-${substr(var.location, 0, 5)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall[0].id
    public_ip_address_id = azurerm_public_ip.firewall[0].id
  }

  tags = var.common_tags
}

resource "azurerm_route_table" "hub" {
  name                          = "rt-${var.organization_name}-${var.environment}-hub"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false

  route {
    name           = "default-to-firewall"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = var.enable_firewall ? "VirtualAppliance" : "Internet"
    next_hop_in_ip_address = var.enable_firewall ? azurerm_firewall.hub[0].ip_configuration[0].private_ip_address : null
  }

  tags = var.common_tags
}

