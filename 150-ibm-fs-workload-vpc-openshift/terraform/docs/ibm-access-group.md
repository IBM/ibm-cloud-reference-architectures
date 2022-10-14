# IBM Cloud Access Group creation module

Terraform module to provision ADMIN, EDIT, and VIEW access groups for the resource groups provided. The resource groups are optionally created as well.

The access group names are generated based on the resource group name under the following formatting rules:

- All upper case letters
- Dashes (-) replaced with underscores (_)
- Suffix of either `_ADMIN`, `_EDIT`, or `_VIEW`

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.5.3

## Example usage

[Refer test cases for more details](test/stages/stage2-access-group.tf)

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

module "access_groups" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-access-group.git"
  
  resource_group_name  = module.resource_group.name
}
```

