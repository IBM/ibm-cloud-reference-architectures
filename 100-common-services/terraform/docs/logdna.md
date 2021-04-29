# IBM Cloud LogDNA service terraform module

Module to provision a LogDNA instance.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.9.0

## Module dependencies

None
## Example usage

```hcl-terraform
module "logdna" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna.git"

  resource_group_name      = var.resource_group_name
  region                   = var.region
  provision                = true
  name_prefix              = var.name_prefix
}

```

