provider "azurerm" {
  features {}
}

module "key-vault" {
  source = "../../"
}
