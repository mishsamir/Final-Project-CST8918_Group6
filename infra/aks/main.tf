resource "azurerm_kubernetes_cluster" "aks" {
  for_each = {
    test = {
      node_count = 1
    }
    prod = {
      node_count = 2
    }
  }

  name                = "aks-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${each.key}"

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_B2s"
    node_count = each.value.node_count
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.29.15"

  tags = {
    ProjectName = "CST8918-Final"
    Environment = each.key
    Course      = "CST8918"
    Service     = "AKS"
  }
}
