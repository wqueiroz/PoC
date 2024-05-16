output "client_certificate" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  //sensitive = true
}

output "kube_config" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks.kube_config_raw)

  //sensitive = true
}

output "client_key" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
}

output "cluster_ca_certificate" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

output "cluster_username" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks.kube_config.0.username)
}

output "cluster_password" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks.kube_config.0.password)
}

output "host" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks.kube_config.0.host)
}
