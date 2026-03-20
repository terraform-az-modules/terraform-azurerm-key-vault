# Terraform version
terraform {
  required_version = ">= 1.10.0"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.85.0"
    }
  }

  provider_meta "azurerm" {
    module_name = "terraform-az-modules/terraform-azurerm-key-vault"
  }
}
