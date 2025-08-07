variable "resource_group_name" {
  description = "The name of the resource group for network resources"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "group_number" {
  description = "Group number for naming"
  type        = string
}
