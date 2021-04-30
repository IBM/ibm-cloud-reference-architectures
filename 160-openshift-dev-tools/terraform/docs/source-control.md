# Source Control module

Terraform module to set up ClusterLink in an ocp 4.x cluster. Eventually this module will be 
expanded to optionally create and register the gitops repo.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v12
- kubectl

### Terraform providers

- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/ibm-garage-cloud/terraform-ibm-container-platform.git
- Namespace - github.com/ibm-garage-clout/terraform-cluster-namespace.git

## Example usage

```hcl-terraform
module "dev_tools_source-control" {
  source = "./module"

  config_file_path = module.dev_cluster.config_file_path
  cluster_type_code = module.dev_cluster.type_code
  cluster_namespace = module.dev_capture_tools_state.namespace
  type = "github"
  url = "https://github.com"
}
```
