# IBM Cloud VPC module

Provisions a VPC instance and related resources. The full list of resources provisioned is as follows:

- VPC instance
- VPC network acl
- VPC security group rules
  - *ping* - icmp type 8
  - *public dns* - `161.26.0.10` and `161.26.0.11`
  - *private dns* - `161.26.0.7` and `161.26.0.8`

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.25.0

## Module dependencies

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group.git

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

module "dev_vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc.git?ref=v1.7.2"
  
  resource_group_id   = module.resource_group.id
  resource_group_name = module.resource_group.name
  region              = var.region
  name_prefix         = var.name_prefix
}
```

## Supporting resources

### delete-vpc.sh

Cleaning up a VPC instance can be difficult because the resources need to be removed in a particular order. Running a `terraform delete` from the terraform state that provisioned the VPC instance is the most reliable way to clean up the resources. However, if the terraform state gets corrupted or lost or the VPC resources were provisioned by hand then an alternative approach is required. In order to address this issue, a script has been provided in [scripts/delete-vpc.sh](./scripts/delete-vpc.sh).

#### Prerequisites

##### Software

The `delete-vpc.sh` script has the following software requirements:

- ibmcloud cli - https://cloud.ibm.com/docs/cli?topic=cli-install-ibmcloud-cli
- ibmcloud vpc infrastructure (is) plugin - https://cloud.ibm.com/docs/cli?topic=vpc-infrastructure-cli-plugin-vpc-reference
- `jq` cli - https://stedolan.github.io/jq/download/

##### Environment

The `delete-vpc.sh` script assumes that you have already logged into the IBM Cloud account where the VPC resources have been deployed using the ibmcloud cli. For more information see https://cloud.ibm.com/docs/cli?topic=cli-ibmcloud_cli#ibmcloud_login

#### Usage

Assuming the prerequisites have been met, the script can be run by passing the name of the VPC to remove as the only argument. E.g. 

```shell
./delete-vpc.sh my-vpc
```

The script will delete all of the resources under the VPC in order then finally delete the VPC instance itself.
