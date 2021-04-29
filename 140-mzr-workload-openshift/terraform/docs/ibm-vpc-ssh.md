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

```hcl-terraform
module "vpc-ssh" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh.git"

  resource_group_name = var.resource_group_name
  region              = var.region
  ibmcloud_api_key    = var.ibmcloud_api_key
  name_prefix         = var.name_prefix
}
```

