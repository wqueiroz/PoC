#resource "azurerm_virtual_network" "vnet_hub_prod" {
#  name                = "vnet-hub"
#  location            = var.resourceGroupLocation
#  resource_group_name = var.resourceGroupName
#  address_space       = [var.vnet_hub_address_space]
#  tags = var.common_tags
#}

resource "azurerm_virtual_network" "vnet_aks_prod" {
  name                = var.vnet_aks_name
  location            = var.resourceGroupLocation
  resource_group_name = var.resourceGroupName
  address_space       = [var.vnet_aks_address_space]
  tags = var.common_tags
}

#resource "azurerm_virtual_network_peering" "to_vnet_aks_prod" {
#  name                         = "peer-to-vnet-aks"
#  resource_group_name          = var.resourceGroupName
#  virtual_network_name         = azurerm_virtual_network.vnet_hub_prod.name
#  remote_virtual_network_id    = azurerm_virtual_network.vnet_aks_prod.id
#  allow_virtual_network_access = true
#  allow_forwarded_traffic      = true
#  allow_gateway_transit        = true
#}
#
#resource "azurerm_virtual_network_peering" "to_vnet_hub_prod" {
#  name                         = "peer-to-vnet-hub"
#  resource_group_name          = var.resourceGroupName
#  virtual_network_name         = azurerm_virtual_network.vnet_aks_prod.name
#  remote_virtual_network_id    = azurerm_virtual_network.vnet_hub_prod.id
#  allow_virtual_network_access = true
#  allow_forwarded_traffic      = true
#}
