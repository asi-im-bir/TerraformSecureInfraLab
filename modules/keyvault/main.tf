# Key Vault Module: stores SSH key and secrets

resource "azurerm_key_vault" "this" {
  name                = "kv-secure-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  # For testing - disable purge protection
  purge_protection_enabled = false
  soft_delete_retention_days = 7

  # This block is essential for setting permissions.
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

# to generate the random KV Name
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}