# ┌────────────────────────────────────────────┐
# │ Provider & Backend Configuration           │
# └────────────────────────────────────────────┘

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "439e5b81-a7f9-44cf-a0ab-d6b1eab690ee"
  features {}

  # Disable automatic registration since we don't need all providers
  resource_provider_registrations = "none"
}
