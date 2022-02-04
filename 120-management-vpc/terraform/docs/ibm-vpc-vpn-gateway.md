# VPN Gateway module

Module to provision VPN Gateway instance(s) into the provided list of subnets.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v0.15

### Terraform providers

- IBM Cloud provider >= 1.9.0

## Module dependencies

This module makes use of the output from other modules:

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group
- VPC subnets - github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets

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

module "vpn_gateway" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpn-gateway.git"

  resource_group_id = module.resource_group.id
  region            = var.region
  ibmcloud_api_key  = var.ibmcloud_api_key
  vpc_name          = module.subnets.vpc_name
  vpc_subnet_count  = module.subnets.count
  vpc_subnets       = module.subnets.subnets
}
```

