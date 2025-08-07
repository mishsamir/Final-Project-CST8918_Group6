resource "azurerm_resource_group" "network" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    ProjectName = "CST8918-Final"
    Environment = "network"
    Course      = "CST8918"
    Group       = var.group_number
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "project-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.0.0.0/14"]

  tags = {
    ProjectName = "CST8918-Final"
    Environment = "network"
    Course      = "CST8918"
    Group       = var.group_number
  }
}

resource "azurerm_subnet" "subnets" {
  for_each = {
    prod  = "10.0.0.0/16"
    test  = "10.1.0.0/16"
    dev   = "10.2.0.0/16"
    admin = "10.3.0.0/16"
  }

  name                 = "${each.key}-subnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}
