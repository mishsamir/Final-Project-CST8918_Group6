# Variables for the root Terraform configuration

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "cst8918-final-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Canada Central"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "cst8918"
}

variable "group_number" {
  description = "Group number for resource naming"
  type        = string
  default     = "01"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Project     = "CST8918-Final"
    Environment = "dev"
    Course      = "CST8918"
  }
}
