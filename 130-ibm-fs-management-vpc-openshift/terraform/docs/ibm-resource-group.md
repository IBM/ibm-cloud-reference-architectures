# IBM Cloud Resource Group module

Terraform module to create a resource groups in an IBM Cloud account.  

Migrated from https://github.com/cloud-native-toolkit/terraform-ibm-resource-group

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v0.13

### Terraform providers

- IBM Cloud provider >= 1.17.0

## Example usage

[Refer the testcase for more details](test/stages/stage1-resource-groups.tf)

```hcl-terraform
terraform {
  required_providers {
    ibm = {
      source = "ibm-cloud/ibm"
    }
  }
  required_version = ">= 0.13"
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API Key"
}

module "resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"

  resource_group_name = var.resource_group_name
  ibmcloud_api_key    = var.ibmcloud_api_key
}
```
