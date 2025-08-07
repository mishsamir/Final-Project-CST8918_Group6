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

resource "azurerm_kubernetes_cluster" "remix_aks" {
  name                = "remix-aks-test"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "remix-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.30.0"

  tags = {
    ProjectName = "CST8918-Final"
    Environment = "test"
    Course      = "CST8918"
    Service     = "AKS"
    Application = "remix-weather"
  }
}
