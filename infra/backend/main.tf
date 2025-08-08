terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource group for backend storage
resource "azurerm_resource_group" "backend_rg" {
  name     = "cst8918-backend-rg"
  location = "Canada Central"

  tags = {
    ProjectName = "CST8918-Final"
    Environment = "backend"
    Course      = "CST8918"
  }
}

# Storage account for Terraform state
resource "azurerm_storage_account" "sa" {
  name                     = "cst8918tfstate6"
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    ProjectName = "CST8918-Final"
    Environment = "backend"
    Course      = "CST8918"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
