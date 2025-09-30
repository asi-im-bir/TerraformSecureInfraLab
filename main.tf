# ┌────────────────────────────────────────────┐
# │ Root Terraform Configuration - main.tf     │
# └────────────────────────────────────────────┘
# Data source for current Azure client
data "azurerm_client_config" "current" {}

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      CreatedDate = timestamp()
    }
  )
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.resource_group_location


  vnet_cidr           = var.vnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

  enable_rdp_rule    = var.enable_rdp_rule
  allowed_admin_cidr = var.allowed_admin_cidr
}

# for compute #
module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.resource_group_location
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_id   = module.network.private_subnet_id

  key_vault_name = "kv-dev-temp123" # to change not hardcoded
  admin_username = var.admin_username
  vm_size        = "Standard_B1s"

  # Optional parameters with defaults
  enable_monitoring      = true
  enable_auto_shutdown   = true
  auto_shutdown_time     = "1900"
  auto_shutdown_timezone = "UTC"

  tags = var.tags

  # Important: Ensure Key Vault is created before VMs
  # depends_on = [
  # module.keyvault
  #module.security
  # ]
}

# Module to manage Key Vault resources
module "keyvault" {
  source = "./modules/keyvault"

  kv_name        = "my-secure-infra-keyvault"
  location       = var.resource_group_location
  resource_group = azurerm_resource_group.rg.name
  tenant_id      = data.azurerm_client_config.current.tenant_id
  object_id      = data.azurerm_client_config.current.object_id
}

resource "random_password" "db_password" {
  length  = 32
  special = true
}

module "security" {
  source = "./modules/security" # Corrected path

  # Required arguments for the security module
  key_vault_name                 = module.keyvault.kv_name
  key_vault_id                   = module.keyvault.id
  database_password_secret_value = random_password.db_password.result
  private_vm_object_id           = module.compute.private_vm_principal_id
  resource_group_name            = azurerm_resource_group.rg.name
  location                       = var.resource_group_location
  tenant_id                      = data.azurerm_client_config.current.tenant_id
  object_id                      = data.azurerm_client_config.current.object_id
}