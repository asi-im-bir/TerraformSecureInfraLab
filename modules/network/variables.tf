variable "location" {
  description = "Region where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name (Azure only)"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the VNET"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.1.0/24"
}


variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "allowed_admin_cidr" {
  description = "Your public IP in CIDR form (e.g., 203.0.113.7/32)"
  type        = string
}

variable "enable_rdp_rule" {
  description = "Allow RDP (3389) from admin IP"
  type        = bool
  default     = false
}