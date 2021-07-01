# IBM Object Storage terraform module

Module to work with an IBM Cloud Object Storage instance. If the `provision` flag is true then an new instance of IBM Cloud Object Storage is provisioned. Otherwise, the module will find an existing instance with the provided name and create a credential. The name and id of the Object Storage instance as well as the name and id of the credential instance are exported from the module for use by other modules.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.18

## Module dependencies

None

## Example usage

```hcl-terraform
module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage.git"

  resource_group_name = var.resource_group_name
  name_prefix         = var.name_prefix
  provision           = var.cos_provision
  resource_location   = var.cos_resource_location
}
```
