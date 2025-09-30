variable "key_vault_id" {
  description = "The ID of the Key Vault."
  type        = string
}

variable "database_password_secret_value" {
  description = "The secret value for the database password."
  type        = string
  sensitive   = true
}

variable "private_vm_object_id" {
  description = "The Object ID of the private VM's managed identity."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Tenant ID."
  type        = string
}
# In modules/security/variables.tf

variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "object_id" {
  description = "The Object ID of the user or service principal."
  type        = string
}

# In modules/security/variables.tf

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region for the resources."
  type        = string
}