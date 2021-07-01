# IBM Cloud Resource Group module

Terraform module to create a resource groups in an IBM Cloud account.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.5.3

## Example usage

```hcl-terraform
module "resource_groups" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-resource-group.git"

  resource_group_name = var .resource_group_name
}
```

