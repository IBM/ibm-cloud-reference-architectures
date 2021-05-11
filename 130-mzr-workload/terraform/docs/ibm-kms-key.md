# KMS Key

Module to manage the Key Management System key. A new key can either be provisioned or an existing key can be looked up.

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
module "kms_key" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms-key.git"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name             = var.kms_key_name
  provision        = var.kms_key_provision
  kms_id           = module.hpcs.guid
}
```
