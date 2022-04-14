# Virtual Private Gateway module

Module to provision a Virtual Private Gateway for a provided resource into a provided set of subnets. It is expected that the subnets and the resource (e.g. object storage) have already been provisioned either at a previous time or by the appropriate terraform modules. This module takes the crn of the resource and the ids of the subnets as input then connects the two together with a Virtual Private Gateway. The result of this module will be a virtual private endpoint created in each of the subnets that provides a private network path between the VPC network and the resource through the gateway.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v015

### Terraform providers

- IBM Cloud provider >= 1.22.0

## Module dependencies

This module makes use of the output from other modules:

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-grou
- VPC - github.com/cloud-native-toolkit/terraform-ibm-vpc
- VPC Subnets - github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets
- Resource module - [Any one of the modules that provision resources on IBM Cloud]

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

module "vpe" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpe-gateway.git"

  resource_group_name = module.resource_group.name
  region              = var.region
  ibmcloud_api_key    = var.ibmcloud_api_key
  name_prefix         = var.name_prefix
  vpc_id              = module.vpc.id
  vpc_subnets         = module.subnets.subnets
  vpc_subnet_count    = module.subnets.count
  resource_label      = "cos"
  resource_crn        = module.cos.crn
}
```
