# IBM Cloud VPC Public Gateway

Terraform module to provision public gateways for an existing VPC instance. Public gateways are restricted to having a single gateway per zone, which means no more than three gateways can be created. If fewer than three zones are required then the `subnet_count` can be set to the appropriate value.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v0.15

### Terraform providers

- IBM Cloud provider >= 1.22.0

## Module dependencies

This module makes use of the output from other modules:

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group.git
- VPC - github.com/cloud-native-toolkit/terraform-ibm-vpc.git

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

module "gateways" {
  source = "cloud-native-toolkit/vpc-gateways/ibm"

  resource_group_id = module.resource_group.id
  region            = var.region
  vpc_name          = module.vpc.name
  subnet_count      = var.vpc_subnet_count
}
```
