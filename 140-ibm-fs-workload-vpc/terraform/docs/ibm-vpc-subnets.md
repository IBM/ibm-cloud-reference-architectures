# IBM VPC Subnets

Terraform module to provision subnets for an existing VPC. The number of subnets created depends on the value provided for `_count`. The created subnets will be named after the vpc with a suffix based on the value provided for `label`. Optionally, if values are provided for `gateways` then the subnets will be created with a public gateway.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.22.0
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- Resource Group - github.com/cloud-native-toolkit/terraform-ibm-container-platform.git
- VPC - github.com/cloud-native-toolkit/terraform-ibm-vpc.git
- Gateway - github.com/cloud-native-toolkit/terraform-ibm-vpc-gateways.git

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

module "dev_subnet" {
  source = "cloud-native-toolkit/vpc-subnets/ibm"
  
  resource_group_id   = module.resource_groups.id
  vpc_name            = module.vpc.name
  acl_id              = module.vpc.acl_id
  gateways            = module.gateways.gateways
  _count              = var.vpc_subnet_count
  region              = var.region
  label               = var.label
  ibmcloud_api_key    = var.ibmcloud_api_key
```
