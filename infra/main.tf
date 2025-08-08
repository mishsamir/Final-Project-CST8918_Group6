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

# Backend module (creates its own resources)
module "backend" {
  source = "./backend"
}

# Network module (create this first to establish the resource group)
module "network" {
  source = "./network"

  resource_group_name = "${var.project_name}-final-project-group-${var.group_number}"
  location            = var.location
  group_number        = var.group_number
}

# AKS module
module "aks" {
  source = "./aks"

  location            = var.location
  resource_group_name = module.network.resource_group_name
}

# Remix Weather App module
module "remix_weather" {
  source = "./remix-weather"

  location            = var.location
  resource_group_name = module.network.resource_group_name
  acr_name            = "${var.project_name}acr${random_string.suffix.result}"
}

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}
