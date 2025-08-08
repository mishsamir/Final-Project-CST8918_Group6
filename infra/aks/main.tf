resource "azurerm_kubernetes_cluster" "aks" {
  for_each = {
    test = {
      min_count  = 1
      max_count  = 1
    }
    prod = {
      min_count  = 1
      max_count  = 3
    }
  }

  name                = "aks-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${each.key}"

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_B2s"
    min_count  = each.value.min_count
    max_count  = each.value.max_count

    auto_scaling_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.31.10"

  tags = {
    ProjectName = "CST8918-Final"
    Environment = each.key
    Course      = "CST8918"
    Service     = "AKS"
  }
}
