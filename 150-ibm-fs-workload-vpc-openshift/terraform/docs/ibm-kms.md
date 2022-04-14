# KMS module

Module to provision and/or lookup a Key Management Service (KMS) on IBM Cloud. 

Within IBM Cloud there are two options for Key Management Services: bring-your-own-key software-based Key Protect service and keep-your-own-key HMS Hyper Protect Crypto Service (HPCS). As you might imagine, the cost of each of these services is significantly different and it is often preferable to use Key Protect in POC and development environments then switch to HPCS for critical environments.

Fortunately, the APIs used to access Key Protect and HPCS are the same making them easily interchangeable. This module makes use of the Key Protect and HPCS modules as submodules and conditionally provisions one or the other based on the value of the `service` variable. If `keyprotect` is provided for the value then an instance of Key Protect is provisioned. If `hpcs` is provided then an HPCS instance is used. If an instance of Key Protect or HPCS already exists then you can provide `false` in the value for the `provision` flag and the module will look for an existing instance with the name provided.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v14

### Terraform providers

None

## Module dependencies

This module makes use of the output from other modules:

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group

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

module "kms" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms.git"

  service             = var.service
  resource_group_name = module.resource_group.name
  region              = var.region
  name_prefix         = var.name_prefix
  provision           = true
}
```

