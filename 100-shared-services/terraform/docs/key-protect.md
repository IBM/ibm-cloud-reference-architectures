# Key Protect terraform module

Provisions an instance of Key Protect in the account.

## Example usage

```terraform-hcl
module "dev_infrastructure_keyprotect" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-key-protect?ref=v1.0.0"

  resource_group_name = module.dev_cluster.resource_group_name
  resource_location   = module.dev_cluster.region
  cluster_id          = module.dev_cluster.id
  namespaces          = []
  namespace_count     = 0
  name_prefix         = var.name_prefix
  tags                = []
  plan                = "tiered-pricing"
}
```
