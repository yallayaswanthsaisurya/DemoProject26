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

}