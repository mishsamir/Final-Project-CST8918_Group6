variable "resource_group_name" {
  description = "The name of the resource group for backend storage"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account for Terraform state"
  type        = string
}

variable "container_name" {
  description = "The name of the storage container for Terraform state"
  type        = string
}
