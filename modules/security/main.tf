# This block creates a secret inside the Key Vault.
# It uses the variable passed from the root module.
resource "azurerm_key_vault_secret" "database_password" {
  name         = "db-password"
  value        = var.database_password_secret_value
  key_vault_id = var.key_vault_id
}

# This data block retrieves the client configuration, which is needed for the tenant_id and object_id.
# This is correct and should remain.
data "azurerm_client_config" "current" {}


# This block creates an access policy for the Key Vault, granting access to a VM.
# It also uses the variable passed from the root module.
resource "azurerm_key_vault_access_policy" "vm_access" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = var.private_vm_object_id

  secret_permissions = [
    "Get",
  ]
}