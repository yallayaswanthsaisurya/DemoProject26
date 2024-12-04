terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "c00531d6-c3a3-48bf-8a58-2cc719fdca4d"
  client_id  = "142ce2ac-6f62-4204-9b9f-6f6099727687"
  client_secret  = "Phs8Q~nu0XKlBuHKs6S-93Rj6cnNnTuQNriM.dcx"
  tenant_id   = "04de910f-1e14-468a-9411-489fb3141296"

}
