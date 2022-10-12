# Activity Tracker terraform module

Terraform module to provision Activity Tracker on IBM Cloud.

If an existing instance of the activity tracker service already exists within the user's account in the specified region, then creation will **NOT** fail, and the outputs of this module will be the values of the existing instnace, not of a newly created instance. 

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.5.3

## Module dependencies

None

## Example usage

[Refer test cases for more details](test/stages/stage2-activity-tracker.tf)

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

module "dev_activity-tracker" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-activity-tracker"

  resource_group_name = var.resource_group_name
  resource_location   = var.region
  tags                = []
  name_prefix         = var.name_prefix
  plan                = "7-day"             
}
```

