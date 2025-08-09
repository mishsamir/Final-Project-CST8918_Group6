# Backend outputs
output "backend_storage_account_name" {
  description = "Name of the storage account for Terraform state"
  value       = module.backend.storage_account_name
}

output "backend_container_name" {
  description = "Name of the storage container for Terraform state"
  value       = module.backend.container_name
}

output "backend_resource_group_name" {
  description = "Name of the backend resource group"
  value       = module.backend.resource_group_name
}

# Network outputs
output "network_resource_group_name" {
  description = "Name of the network resource group"
  value       = module.network.resource_group_name
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.network.vnet_name
}

# ACR outputs
output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = module.remix_weather.acr_name
}

output "acr_login_server" {
  description = "Login server URL for the Azure Container Registry"
  value       = module.remix_weather.acr_login_server
}

# AKS outputs
output "aks_clusters" {
  description = "Information about AKS clusters"
  value = {
    for k, cluster in module.aks.clusters : k => {
      name = cluster.name
      id   = cluster.id
      fqdn = cluster.fqdn
    }
  }
}

# Redis Cache outputs
output "redis_test_hostname" {
  description = "Hostname of the Redis cache for test environment"
  value       = module.remix_weather.redis_test_hostname
}

output "redis_prod_hostname" {
  description = "Hostname of the Redis cache for production environment"
  value       = module.remix_weather.redis_prod_hostname
}
