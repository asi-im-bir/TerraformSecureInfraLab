variable "location" {
  description = "Deployment region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where VM will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet for bastion VM"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet for private VM"
  type = string
}

variable "environment" {
  description = "Environment name (dev/staging/prod)"
  type        = string
  default     = "dev"
}

variable "vm_prefix" {
  description = "Prefix for VM resources"
  type        = string
  default     = "secure"
}

variable "public_nsg_id" {
  description = "ID of the NSG for public subnet"
  type        = string
  default     = ""
}

variable "private_nsg_id" {
  description = "ID of the NSG for private subnet"
  type        = string
  default     = ""
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureadmin"

  validation {
    condition     = length(var.admin_username) > 0 && length(var.admin_username) <= 20
    error_message = "Admin username must be between 1 and 20 characters."
  }
}

variable "vm_size" {
  description = "Size of the VMs"
  type        = string
  default     = "Standard_B1s"

  validation {
    condition     = contains(["Standard_B1s", "Standard_B1ms", "Standard_B2s"], var.vm_size)
    error_message = "VM size must be a B-series for cost optimization."
  }
}

variable "key_vault_name" {
  description = "Name of the Key Vault for storing secrets"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_monitoring" {
  description = "Enable Azure Monitor extension"
  type        = bool
  default     = true
}

variable "enable_auto_shutdown" {
  description = "Enable auto-shutdown for cost savings"
  type        = bool
  default     = true
}

variable "auto_shutdown_time" {
  description = "Time for auto-shutdown (24hr format)"
  type        = string
  default     = "1900"  # 7 PM
}

variable "auto_shutdown_timezone" {
  description = "Timezone for auto-shutdown"
  type        = string
  default     = "UTC"
}