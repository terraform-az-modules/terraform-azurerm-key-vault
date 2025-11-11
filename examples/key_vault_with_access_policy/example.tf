provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current_client_config" {}

# ------------------------------------------------------------------------------
# Resource Group
# ------------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.3"
  name        = "app"
  environment = "test"
  label_order = ["environment", "name", "location"]
  location    = "canadacentral"
}

# ------------------------------------------------------------------------------
# Virtual Network
# ------------------------------------------------------------------------------
module "vnet" {
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.3"
  name                = "app"
  environment         = "test"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}


# ------------------------------------------------------------------------------
# Subnet
# ------------------------------------------------------------------------------
module "subnet" {
  source               = "terraform-az-modules/subnet/azurerm"
  version              = "1.0.1"
  environment          = "test"
  label_order          = ["name", "environment", "location"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name
  subnets = [
    {
      name            = "subnet1"
      subnet_prefixes = ["10.0.1.0/24"]
    }
  ]
}

# ------------------------------------------------------------------------------
# Log Analytics
# ------------------------------------------------------------------------------
module "log-analytics" {
  source                           = "terraform-az-modules/log-analytics/azurerm"
  version                          = "1.0.2"
  name                             = "app"
  environment                      = "test"
  location                         = module.resource_group.resource_group_location
  label_order                      = ["name", "environment", "location"]
  log_analytics_workspace_sku      = "PerGB2018"
  log_analytics_workspace_id       = module.log-analytics.workspace_id
  resource_group_name              = module.resource_group.resource_group_name
}

module "private-dns-zone" {
  source              = "terraform-az-modules/private-dns/azurerm"
  version             = "1.0.2"
  name        = "app"
  environment = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  label_order        = ["name", "environment", "location"]
  private_dns_config = [
    {
      resource_type = "key_vault"
      vnet_ids      = [module.vnet.vnet_id]
    }
  ]
}

# ------------------------------------------------------------------------------
# Key Vault
# ------------------------------------------------------------------------------
module "vault" {
  source                        = "../.."
  name                          = "core"
  environment                   = "dev"
  label_order                   = ["name", "environment", "location"]
  resource_group_name           = module.resource_group.resource_group_name
  location                      = module.resource_group.resource_group_location
  subnet_id                     = module.subnet.subnet_ids["subnet1"]
  enable_rbac_authorization     = false
  private_dns_zone_ids          = module.private-dns-zone.private_dns_zone_ids.key_vault
  public_network_access_enabled = true
  enable_access_policies        = true
  access_policies = {
    "app-server" = {
      tenant_id               = data.azurerm_client_config.current_client_config.tenant_id,
      object_id               = data.azurerm_client_config.current_client_config.object_id,
      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
      certificate_permissions = ["Get", "List"]
      storage_permissions     = []
    },
    "admin-server" = {
      tenant_id               = data.azurerm_client_config.current_client_config.tenant_id,
      object_id               = data.azurerm_client_config.current_client_config.object_id,
      key_permissions         = ["Get", "List", "Create", "Delete", "Purge", "Recover", "Backup", "Restore"]
      secret_permissions      = ["Get", "List", "Set", "Delete", "Purge", "Recover", "Backup"]
      certificate_permissions = ["Get", "List", "Create", "Delete", "Purge", "Recover"]
    },
  }
  diagnostic_setting_enable  = true
  log_analytics_workspace_id = module.log-analytics.workspace_id
}
