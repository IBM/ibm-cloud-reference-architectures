# VPN Gateway module

Module to provision VPN Gateway instance(s) into the provided list of subnets.

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

[Refer test case for more details](test/stages/stage2-vpn-gateways.tf)

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

