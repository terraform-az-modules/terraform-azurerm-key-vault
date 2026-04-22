## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_policies | List of access policies to be applied to the Key Vault. Each policy can specify permissions for keys, secrets, certificates, and storage. | <pre>map(object({<br>    tenant_id               = string<br>    object_id               = string<br>    application_id          = optional(string, null)<br>    key_permissions         = optional(list(string), [])<br>    secret_permissions      = optional(list(string), [])<br>    certificate_permissions = optional(list(string), [])<br>    storage_permissions     = optional(list(string), [])<br>  }))</pre> | `{}` | no |
| admin\_objects\_ids | IDs of the objects that can do all operations on all keys, secrets and certificates. | `list(string)` | `[]` | no |
| certificate\_contacts | Contact information to send notifications triggered by certificate lifetime events | <pre>list(object({<br>    email = string<br>    name  = optional(string)<br>    phone = optional(string)<br>  }))</pre> | `[]` | no |
| custom\_name | Override default naming convention | `string` | `null` | no |
| deployment\_mode | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| diagnostic\_setting\_enable | Boolean flag to specify whether Diagnostic Settings should be enabled for the Key Vault. Defaults to false. | `bool` | `false` | no |
| enable\_access\_policies | Boolean flag to specify whether access policies should be enabled for the Key Vault. Defaults to true. | `bool` | `false` | no |
| enable\_private\_endpoint | Manages a Private Endpoint to Azure database for MySQL | `bool` | `true` | no |
| enable\_rbac\_authorization | (Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | `true` | no |
| enabled | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| enabled\_for\_deployment | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| enabled\_for\_disk\_encryption | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false | `bool` | `true` | no |
| enabled\_for\_template\_deployment | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| eventhub\_authorization\_rule\_id | Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data. | `string` | `null` | no |
| eventhub\_name | Specifies the name of the Event Hub where Diagnostics Data should be sent. | `string` | `null` | no |
| extra\_tags | Variable to pass extra tags. | `map(string)` | `null` | no |
| kv\_logs | values for Key Vault logs. The `category` attribute is optional and can be used to specify which categories of logs to enable. If not specified, all categories will be enabled. | <pre>object({<br>    enabled        = bool<br>    category       = optional(list(string))<br>    category_group = optional(list(string))<br>  })</pre> | <pre>{<br>  "category_group": [<br>    "AllLogs"<br>  ],<br>  "enabled": true<br>}</pre> | no |
| label\_order | Order of labels in the resource name. The order of labels in the resource name. The default order is ['name', 'environment', 'location']. You can change this to ['environment', 'name', 'location'] or any other order as per your requirements. | `list(any)` | <pre>[<br>  "name",<br>  "environment",<br>  "location"<br>]</pre> | no |
| location | The location/region where the key vault is created. Changing this forces a new resource to be created. | `string` | `""` | no |
| log\_analytics\_destination\_type | Possible values are AzureDiagnostics and Dedicated, default to AzureDiagnostics. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table. | `string` | `"AzureDiagnostics"` | no |
| log\_analytics\_workspace\_id | The ID of the Log Analytics Workspace where logs should be sent. | `string` | `null` | no |
| managed\_hardware\_security\_module\_enabled | Create a KeyVault Managed HSM resource if enabled. Changing this forces a new resource to be created. | `bool` | `false` | no |
| managedby | ManagedBy, eg 'terraform-az-modules'. | `string` | `"terraform-az-modules"` | no |
| metric\_enabled | Boolean flag to specify whether Metrics should be enabled for the Key Vault. Defaults to true. | `bool` | `true` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| network\_acls | Network ACLs for the Key Vault. The `bypass` attribute can be set to 'AzureServices' to allow Azure services to bypass the firewall.<br>  - The `default_action` attribute can be set to 'Allow' or 'Deny',<br>  - The `ip_rules` attribute is a list of IP addresses or CIDR ranges that are allowed access,<br>  - the `virtual_network_subnet_ids` attribute is a list of subnet IDs that are allowed access. | <pre>object({<br>    bypass                     = optional(string, "None"),<br>    default_action             = optional(string, "Deny"),<br>    ip_rules                   = optional(list(string)),<br>    virtual_network_subnet_ids = optional(list(string)),<br>  })</pre> | <pre>{<br>  "bypass": "AzureServices",<br>  "default_action": "Allow",<br>  "ip_rules": [<br>    "0.0.0.0/0"<br>  ],<br>  "virtual_network_subnet_ids": []<br>}</pre> | no |
| private\_dns\_zone\_ids | The ID of the private DNS zone. | `string` | `null` | no |
| public\_network\_access\_enabled | (Optional) Whether public network access is allowed for this Key Vault. Defaults to true | `bool` | `false` | no |
| purge\_protection\_enabled | Boolean flag to specify whether purge protection is enabled for the Key Vault. Defaults to true. When enabled, the Key Vault cannot be permanently deleted until the purge protection is disabled. | `bool` | `true` | no |
| reader\_objects\_ids | IDs of the objects that can read all keys, secrets and certificates. | <pre>map(object({<br>    role_definition_name = string<br>    principal_id         = string<br>  }))</pre> | `{}` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/terraform-az-modules/terraform-azure-key-vault"` | no |
| resource\_group\_name | The name of the resource group in which to create the network security group. | `string` | `""` | no |
| resource\_position\_prefix | Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.<br><br>- If true, the keyword is prepended: "vnet-core-dev".<br>- If false, the keyword is appended: "core-dev-vnet".<br><br>This helps maintain naming consistency based on organizational preferences. | `bool` | `true` | no |
| secrets | List of objects that represent the configuration of each secrect. | <pre>list(object({<br>    name            = string<br>    value           = string<br>    content_type    = optional(string)<br>    not_before_date = optional(string)<br>    expiration_date = optional(string)<br>  }))</pre> | `[]` | no |
| sku\_name | The Name of the SKU used for this Key Vault. Possible values are standard and premium | `string` | `"standard"` | no |
| sku\_name\_hsm | The Name of the SKU used for this Key Vault hsm. | `string` | `"Standard_B1"` | no |
| soft\_delete\_retention\_days | The number of days that items should be retained for once soft-deleted. The valid value can be between 7 and 90 days | `number` | `90` | no |
| storage\_account\_id | The ID of the Storage Account where logs should be sent. | `string` | `null` | no |
| subnet\_id | The resource ID of the subnet | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | value of the Key Vault ID |
| vault\_uri | value of the Key Vault URI |

