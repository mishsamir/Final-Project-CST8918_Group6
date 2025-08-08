# Azure Container Registry for storing Docker images
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    ProjectName = "CST8918-Final"
    Environment = "shared"
    Course      = "CST8918"
    Service     = "ACR"
  }
}

# Azure Cache for Redis - Test Environment
resource "azurerm_redis_cache" "test" {
  name                = "remix-weather-redis-test"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  non_ssl_port_enabled = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }

  tags = {
    ProjectName = "CST8918-Final"
    Environment = "test"
    Course      = "CST8918"
    Service     = "Redis"
    Application = "remix-weather"
  }
}

# Azure Cache for Redis - Production Environment
resource "azurerm_redis_cache" "prod" {
  name                = "remix-weather-redis-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  non_ssl_port_enabled = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }

  tags = {
    ProjectName = "CST8918-Final"
    Environment = "prod"
    Course      = "CST8918"
    Service     = "Redis"
    Application = "remix-weather"
  }
}
