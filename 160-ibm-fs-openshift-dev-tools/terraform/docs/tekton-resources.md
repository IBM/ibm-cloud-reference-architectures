# Tekton resources terraform module

Terraform module to install Tekton resources (tasks and pipelines) into the cluster.

## Dependencies

- Cluster module
- Namespace module
- Tekton module

## Example usage

```hcl-terraform
module "dev_tools_tekton_resources" {
  source = "github.com/ibm-garage-cloud/terraform-tools-tekton-resources.git?v2.0.0"

  cluster_type             = module.dev_cluster.type_code
  cluster_config_file_path = module.dev_cluster.config_file_path
  resource_namespace       = module.dev_capture_state.namespace
}
```
