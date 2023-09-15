variable "resource_group_name" {
  type = string
  description = "Resource group name"
}

variable "location" {
  type    = string
  default = "westeurope"

  validation {
    condition     = contains(["westeurope", "northeurope"], var.location)
    error_message = "Location must be either westeurope or northeurope"
  }
}

variable "environment" {
  type        = string
  description = "Environment name"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either dev or prod"
  }
}

variable "project_prefix" {
  type        = string
  description = "Project prefix"

  validation {
    condition     = length(var.project_prefix) == 3
    error_message = "Project prefix must be 3 characters long"
  }
}