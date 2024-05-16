locals {
  default_tags     = {
    environment = "PSTI-PROD",
    project = "PIX 2.0"
  }
x}

data "azurerm_resource_group" "rg-pix2" {
  name     = var.resourceGroupName
}

module "network" {
  source   = "./network"
  resourceGroupName = data.azurerm_resource_group.rg-pix2.name
  resourceGroupLocation = data.azurerm_resource_group.rg-pix2.location
  common_tags = merge(local.default_tags, var.global_tags)
  #global_subnet_address_space = var.global_subnet_address_space
  vnet_aks_address_space = var.vnet_aks_address_space
  vnet_aks_name = var.vnet_aks_name
}

module "aks" {
  source = "./aks"
  resourceGroupName = data.azurerm_resource_group.rg-pix2.name
  resourceGroupLocation = data.azurerm_resource_group.rg-pix2.location
  common_tags = merge(local.default_tags, var.global_tags)
  vnet_aks_name = module.network.vnet_aks_name
  vnet_aks_id = module.network.vnet_aks_id
  defaultNodeVmSize = var.defaultNodeVmSize
  defaultNodeCount = var.defaultNodeCount
  sp_client_id = var.aks_service_principal_client_id
  sp_client_password = var.aks_service_principal_client_secret
  storageAccountName = var.storageAccountName
  aks_subnet_address_space = var.aks_subnet_address_space
  #agw_subnet_address_space = var.agw_subnet_address_space
  aksClusterName = var.aksClusterName
  defaultNodePoolName = var.defaultNodePoolName
  authenticationKey = var.authenticationKey
  #global_subnet_address_space = var.global_subnet_address_space
  applicationNodePoolName = var.applicationNodePoolName
  appNodePoolMaxCount = var.appNodePoolMaxCount
  appNodePoolMinCount = var.appNodePoolMinCount
  enableNodePoolAutoScale = var.enableNodePoolAutoScale
  roleContributorScopeRGPIX = var.roleContributorScopeRGPIX
  applicationNodeVmSize = var.applicationNodeVmSize
  appNodeVmCount = var.appNodeVmCount
  defaultNodePoolMaxCount = var.defaultNodePoolMaxCount
}
