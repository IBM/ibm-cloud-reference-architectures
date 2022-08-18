# IBM Object Storage terraform module

Module to work with an IBM Cloud Object Storage instance. If the `provision` flag is true then an new instance of IBM Cloud Object Storage is provisioned. Otherwise, the module will find an existing instance with the provided name and create a credential. The name and id of the Object Storage instance as well as the name and id of the credential instance are exported from the module for use by other modules.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v0.15

### Terraform providers

- IBM Cloud provider >= 1.18

## Module dependencies

None

## Example usage

```hcl-terraform
terraform {
  required_providers {
    ibm = {
      source = "ibm-cloud/ibm"
    }
  }
  required_version = ">= 0.15"
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
}

module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage.git"

  resource_group_name = var.resource_group_name
  name_prefix         = var.name_prefix
  provision           = var.cos_provision
  resource_location   = var.cos_resource_location
}
```
