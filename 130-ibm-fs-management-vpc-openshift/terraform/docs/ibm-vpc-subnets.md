# IBM VPC Subnets

Terraform module to provision subnets for an existing VPC. The number of subnets created depends on the value provided for `_count`. The created subnets will be named after the vpc with a suffix based on the value provided for `label`. Optionally, if values are provided for `gateways` then the subnets will be created with a public gateway.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.22.0

## Module dependencies

This module makes use of the output from other modules:

- Resource Group - github.com/terraform-ibm-modules/terraform-ibm-toolkit-resource-group
- VPC - github.com/terraform-ibm-modules/terraform-ibm-toolkit-vpc
- Gateway - github.com/terraform-ibm-modules/terraform-ibm-toolkit-vpc-gateways

## Example usage

[Refer test cases for more details](test/stages/stage2-subnets.tf)

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
