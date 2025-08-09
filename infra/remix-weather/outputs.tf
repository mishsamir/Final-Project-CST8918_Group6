output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "Login server URL for the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "redis_test_hostname" {
  description = "Hostname of the Redis cache for test environment"
  value       = azurerm_redis_cache.test.hostname
}

output "redis_test_primary_key" {
  description = "Primary access key for Redis cache in test environment"
  value       = azurerm_redis_cache.test.primary_access_key
  sensitive   = true
}

output "redis_prod_hostname" {
  description = "Hostname of the Redis cache for production environment"
  value       = azurerm_redis_cache.prod.hostname
}

output "redis_prod_primary_key" {
  description = "Primary access key for Redis cache in production environment"
  value       = azurerm_redis_cache.prod.primary_access_key
  sensitive   = true
}
