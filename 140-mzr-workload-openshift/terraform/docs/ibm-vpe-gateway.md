# Virtual Private Gateway module

Module to provision a Virtual Private Gateway for a provided resource into a provided set of subnets. It is expected that the subnets and the resource (e.g. object storage) have already been provisioned either at a previous time or by the appropriate terraform modules. This module takes the crn of the resource and the ids of the subnets as input then connects the two together with a Virtual Private Gateway. The result of this module will be a virtual private endpoint created in each of the subnets that provides a private network path between the VPC network and the resource through the gateway.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

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
