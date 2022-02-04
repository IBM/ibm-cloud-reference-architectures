# KMS Key

Module to manage the Key Management System key. A new key can either be provisioned or an existing key can be looked up.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.22.0

## Module dependencies

This module makes use of the output from other modules:

- KMS module
    - github.com/ibm-garage-cloud/terraform-ibm-key-protect.git
    - github.com/ibm-garage-cloud/terraform-ibm-hpcs.git

## Example usage

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
  region = var.region
}

module "kms_key" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms-key.git"

  name             = var.kms_key_name
  provision        = var.kms_key_provision
  kms_id           = module.kms.guid
}
```
