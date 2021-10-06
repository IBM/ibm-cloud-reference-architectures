# KMS module

Module to provision and/or lookup a Key Management Service (KMS) on IBM Cloud. 

Within IBM Cloud there are two options for Key Management Services: bring-your-own-key software-based Key Protect service and keep-your-own-key HMS Hyper Protect Crypto Service (HPCS). As you might imagine, the cost of each of these services is significantly different and it is often preferable to use Key Protect in POC and development environments then switch to HPCS for critical environments.

Fortunately, the APIs used to access Key Protect and HPCS are the same making them easily interchangeable. This module makes use of the Key Protect and HPCS modules as submodules and conditionally provisions one or the other based on the value of the `service` variable. If `keyprotect` is provided for the value then an instance of Key Protect is provisioned. If `hpcs` is provided then an HPCS instance is used. If an instance of Key Protect or HPCS already exists then you can provide `false` in the value for the `provision` flag and the module will look for an existing instance with the name provided.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v14

### Terraform providers

None

## Module dependencies

This module makes use of the output from other modules:

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group

## Example usage

```hcl-terraform
module "dev_tools_argocd" {
  source = "github.com/ibm-garage-cloud/terraform-tools-argocd.git?ref=v1.0.0"

  cluster_config_file = module.dev_cluster.config_file_path
  cluster_type        = module.dev_cluster.type
  app_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  ingress_subdomain   = module.dev_cluster.ingress_hostname
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  name                = "argocd"
}
```

