# Operator Lifecycle Manager module

Installs Operator Lifecycle Manager (OLM) into a cluster. However, if the cluster is OpenShift 4.x
and already has OLM installed then the module does not install anything. It can still be used to export
the olm namespaces for use by downstream modules.

## Example usage

```hcl-terraform
module "dev_software_olm_release" {
  source = "github.com/ibm-garage-cloud/garage-terraform-modules.git//self-managed/software/operator-lifecycle-manager?ref=olm"

  cluster_config_file      = "~/.kube/config"
  cluster_version          = "3.11"
  cluster_type             = "ocp3"
}
```

Another example

```hcl-terraform
module "dev_software_olm_release" {
  source = "github.com/ibm-garage-cloud/garage-terraform-modules.git//self-managed/software/operator-lifecycle-manager?ref=olm"

  cluster_config_file      = module.dev_cluster.config_file_path
  cluster_version          = module.dev_cluster.version
  cluster_type             = var.cluster_type
}
```
