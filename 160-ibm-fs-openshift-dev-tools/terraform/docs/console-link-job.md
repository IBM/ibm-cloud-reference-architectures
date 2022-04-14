# Console Link Job module

Module that installs a cronjob into a cluster that will create console links from routes and config maps.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13
- kubectl

### Terraform providers

- None

## Module dependencies

This module makes use of the output from other modules:

- Cluster
  - github.com/ibm-garage-cloud/terraform-ibm-container-platform
  - github.com/ibm-garage-cloud/terraform-ibm-ocp-vpc
  - github.com/ibm-garage-cloud/terraform-k8s-ocp-cluster
  - github.com/ibm-garage-cloud/terraform-ocp-login
- Namespace 
  - github.com/ibm-garage-cloud/terraform-k8s-namespace

## Example usage

```hcl-terraform
module "console-link-job" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-console-link-job.git"
  
  namespace           = module.console-link_namespace.name
  cluster_config_file = module.cluster.config_file_path
}
```

