# IBM Cloud LogDNA bind module

Module to bind a LogDNA instance to a cluster.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.9.0
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/ibm-garage-cloud/terraform-ibm-container-platform.git
- Namespace - github.com/ibm-garage-clout/terraform-cluster-namespace.git

## Example usage

```hcl-terraform
module "logdna-bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna-bind.git"

  resource_group_name      = var.resource_group_name
  region                   = var.region
  cluster_id               = module.dev_cluster.id
  cluster_name             = module.dev_cluster.name
  cluster_config_file_path = module.dev_cluster.config_file_path
  tools_namespace          = module.dev_capture_state.namespace
  name                     = module.logdna.name
}

```

