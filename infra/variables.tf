# Variables for the root Terraform configuration

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Canada Central"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "cst8918"
}

variable "group_number" {
  description = "Group number for resource naming"
  type        = string
  default     = "06"
}
