variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "location" {
  description = "Deployment region"
  type        = string
}

variable "resource_group" {
  description = "Resource group name (Azure only)"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID (for Key Vault access)"
  type        = string
}

variable "object_id" {
  description = "The object ID for Key Vault access policy."
  type        = string
}
