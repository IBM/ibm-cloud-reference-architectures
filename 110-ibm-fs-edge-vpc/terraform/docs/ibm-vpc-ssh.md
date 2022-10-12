# IBM Cloud VPC SSH module

Module to register an ssh public key into the IBM Cloud infrastructure for use in accessing VPC resources

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v12
- ssh-keygen

### Terraform providers

- TLS provider (provided by Terraform)

## Module dependencies

None

## Example usage

[Refer test cases for more details](test/stages/stage2-vpcssh.tf)

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

module "vpc-ssh" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh.git"

  resource_group_name = var.resource_group_name
  name_prefix         = var.name_prefix
}
```

