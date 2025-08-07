output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "Login server URL for the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "remix_aks_name" {
  description = "Name of the Remix AKS cluster"
  value       = azurerm_kubernetes_cluster.remix_aks.name
}

output "remix_aks_id" {
  description = "ID of the Remix AKS cluster"
  value       = azurerm_kubernetes_cluster.remix_aks.id
}

output "remix_aks_fqdn" {
  description = "FQDN of the Remix AKS cluster"
  value       = azurerm_kubernetes_cluster.remix_aks.fqdn
}
