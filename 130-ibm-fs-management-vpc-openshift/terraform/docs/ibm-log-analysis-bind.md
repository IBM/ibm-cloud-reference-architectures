# IBM Log Analysis bind module

Module to bind an existing IBM Log Analysis instance to a cluster.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v0.13

### Terraform providers

- IBM Cloud provider >= 1.9.0
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/ibm-garage-cloud/terraform-ibm-container-platform.git
- Namespace - github.com/ibm-garage-clout/terraform-cluster-namespace.git

## Example usage

```hcl-terraform
module "log-bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-log-analysis-bind.git"

  resource_group_name      = var.resource_group_name
  region                   = var.region
  ibmcloud_api_key         = var.ibmcloud_api_key
  cluster_id               = module.dev_cluster.id
  cluster_name             = module.dev_cluster.name
  logdna_id                = module.logdna.guid
  logdna_crn               = module.logdna.id
}
```
