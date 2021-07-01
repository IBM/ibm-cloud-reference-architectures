# Create Namespaces terraform module

Creates the namespace with the provided name in the cluster. The namespace and 
its contents will be destroyed first before creating the new namespace. Also, the `cloud-config` and
`cloud-access` configmap and secret will be copied from the default namespace into the new 
namespace.


## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v12
- kubectl

### Terraform providers

- null (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/ibm-garage-cloud/terraform-ibm-container-platform.git

## Example usage

```hcl-terraform
module "namespace" {
  source = "github.com/ibm-garage-cloud/terraform-k8s-namespace.git"

  cluster_config_file_path = module.dev_cluster.config_file_path
  name                     = var.namespace
}
```


