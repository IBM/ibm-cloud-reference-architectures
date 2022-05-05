# IBM Cloud OpenShift VPC cluster

Provisions an IBM Cloud OpenShift VPC cluster using a provided VPC instance and COS
instance.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.18
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- Object Storage - github.com/cloud-native-toolkit/terraform-ibm-object-storage.git
- VPC - github.com/cloud-native-toolkit/terraform-ibm-vpc.git
- Subnet - github.com/cloud-native-toolkit/terraform-ibm-vpc.git

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

module "cluster" {
  source = "cloud-native-toolkit/ocp-vpc/ibm"

  resource_group_name = var.resource_group_name
  region              = var.region
  ibmcloud_api_key    = var.ibmcloud_api_key
  name                = var.cluster_name
  worker_count        = var.worker_count
  ocp_version         = var.ocp_version
  exists              = var.cluster_exists
  name_prefix         = var.name_prefix
  vpc_name            = module.vpc.name
  vpc_subnet_count    = module.subnet.subnet_count
  vpc_subnets         = module.subnet.subnets
  cos_id              = module.cos.id
}
```
