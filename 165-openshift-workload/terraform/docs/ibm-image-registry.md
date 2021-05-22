# IBM Cloud Container Registry terraform module

Terraform module that sets up a namespace within the IBM Cloud Container Registry and configures it in the cluster
for use. Configuring the cluster includes adding the icr pull secret in the cluster-wide pull secret
and adding a ConsoleLink to ocp 4.x clusters.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v12
- oc cli
- ibmcloud cli

### Terraform providers

- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/ibm-garage-cloud/terraform-ibm-container-platform.git
- Namespace - github.com/ibm-garage-clout/terraform-cluster-namespace.git

## Example usage

```hcl-terraform
module "registry" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-image-registry.git"

  resource_group_name = var.resource_group_name
  cluster_region = var.region
  config_file_path = module.dev_cluster.config_file_path
  ibmcloud_api_key = var.ibmcloud_api_key
  cluster_namespace = module.dev_capture_tools_state.namespace
}
```

