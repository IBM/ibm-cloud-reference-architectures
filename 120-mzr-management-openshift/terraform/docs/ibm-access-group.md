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

```hcl-terraform
module "access_groups" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-access-group.git?ref=v1.0.0"
  
  resource_group_name  = module.resource_group.name
}
```

