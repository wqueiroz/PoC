data "azurerm_resource_group" "RG_PIX_2" {
  name = var.resourceGroupName
}



#resource "azurerm_subnet" "global" {
#  name                                           = "snet-global"
#  resource_group_name                            = var.resourceGroupName
#  virtual_network_name                           = data.azurerm_virtual_network.vnet_hub.name
#  address_prefixes                               = [var.global_subnet_address_space]
#  enforce_private_link_endpoint_network_policies = true
#}

#resource "azurerm_subnet" "agw_snet" {
#  name                 = "snet-agw"
#  resource_group_name  = var.resourceGroupName
#  virtual_network_name = data.azurerm_virtual_network.vnet_aks.name
#  address_prefixes     = [var.agw_subnet_address_space]
#}

# create sub net for nodes
resource "azurerm_subnet" "aks_prod_snet" {
  name                                           = "snet-aks"
  resource_group_name                            = var.resourceGroupName
  virtual_network_name                           = var.vnet_aks_name
  address_prefixes                               = [var.aks_subnet_address_space]
  enforce_private_link_endpoint_network_policies = true
}

#create private link
resource "azurerm_private_dns_zone" "aks_dns_zone" {
  name                = "privatelink.${var.resourceGroupLocation}.azmk8s.io"
  resource_group_name = var.resourceGroupName
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_zone_L1" {
  name                  = "pdzvnl-aks-prod-002"
  resource_group_name   = var.resourceGroupName
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns_zone.name
  virtual_network_id    = var.vnet_aks_id
}

# Contributor identity
resource "azurerm_user_assigned_identity" "aks_contrib_id" {
  name                = "id-aks-prod-001"
  resource_group_name = var.resourceGroupName
  location            = var.resourceGroupLocation
}

### Identity role assignment
resource "azurerm_role_assignment" "dns_contributor" {
  scope                = azurerm_private_dns_zone.aks_dns_zone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_contrib_id.principal_id
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = var.vnet_aks_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_contrib_id.principal_id
}

resource "azurerm_role_assignment" "rg_contributor" {
  scope                = data.azurerm_resource_group.RG_PIX_2.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_contrib_id.principal_id
}

#resource "azurerm_role_assignment" "acr" {
#  scope                = azurerm_container_registry.acr.id
#  role_definition_name = "AcrPull"
#  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
#}
#
#resource "azurerm_role_assignment" "agw" {
#  scope                = data.azurerm_resource_group.rg-pix2.id
#  role_definition_name = "Contributor"
#  principal_id         = azurerm_kubernetes_cluster.aks.addon_profile[0].ingress_application_gateway[0] ingress_application_gateway_identity[0].object_id
#}

#resource "azurerm_log_analytics_workspace" "log" {
#  name                = "acctest-02"
#  location            = var.resourceGroupLocation
#  resource_group_name = var.resourceGroupName
#  sku                 = "PerGB2018"
#  retention_in_days   = 30
#}

### AKS cluster creation
resource "azurerm_kubernetes_cluster" "aks" {
  name                                = var.aksClusterName
  location                            = var.resourceGroupLocation
  resource_group_name                 = var.resourceGroupName
  dns_prefix_private_cluster          = "aks-pvaks-prod-001"
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false
  azure_policy_enabled                = true
  private_dns_zone_id                 = azurerm_private_dns_zone.aks_dns_zone.id
  sku_tier                            = "Paid"

  role_based_access_control_enabled = true
  local_account_disabled            = false

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_contrib_id.id]
  }

  linux_profile {
    admin_username = "sysadmin"
    ssh_key {
      key_data = var.authenticationKey
    }
  }

  #  service_principal {
  #    client_id     = var.sp_client_id
  #    client_secret = var.sp_client_password
  #  }

  #only for kube-system
  default_node_pool {
    name                = var.defaultNodePoolName
    node_count          = var.defaultNodeCount
    vm_size             = var.defaultNodeVmSize
    os_disk_size_gb     = 32
    vnet_subnet_id      = azurerm_subnet.aks_prod_snet.id
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = var.enableNodePoolAutoScale
    max_count           = var.defaultNodePoolMaxCount
    min_count           = var.defaultNodeCount
  }

  # create node poo



  network_profile {
    network_policy = "calico"
    network_plugin = "kubenet"
    pod_cidr       = "10.1.0.0/16"
  }

  workload_autoscaler_profile {
    keda_enabled = true
  }

  tags = var.common_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "app_node_pool" {
  name                  = var.applicationNodePoolName
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.applicationNodeVmSize
  os_disk_size_gb       = 64
  node_count            = var.appNodePoolMinCount
  enable_auto_scaling   = var.enableNodePoolAutoScale
  max_count             = var.appNodePoolMaxCount
  min_count             = var.appNodePoolMinCount
  tags                  = var.common_tags
}
