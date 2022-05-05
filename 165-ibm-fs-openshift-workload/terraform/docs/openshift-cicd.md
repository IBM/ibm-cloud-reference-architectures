# Openshift CI/CD module

Module that provisions ArgoCD and Tekton into a cluster. The OpenShift GitOps release of the ArgoCD operator has made the OpenShift Pipelines operator (Tekton) a dependency and will automatically provision the operator if not present. Since the two operators are entangled by the OpenShift GitOps operator, they have been combined here.

If the OpenShift GitOps operator has been deployed (OpenShift 4.6+) then Tekton will have been automatically provisioned and the Tekton module logic will be skipped (the `provision_tekton` flag from the ArgoCD module will be false). Otherwise, the Tekton operator will be installed after the ArgoCD operator.

The presence of the Tekton operator does not preclude the use of other CI tools within the OpenShift cluster.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- None

### Submodules

- ArgoCD module - github.com/cloud-native-toolkit/terraform-tools-argocd
- Tekton module - github.com/cloud-native-toolkit/terraform-tools-tekton

## Module dependencies

This module makes use of the output from other modules:

- Cluster
- OLM

## Example usage

```hcl-terraform
module "openshift_cicd" {
  source = "github.com/ibm-garage-cloud/terraform-tools-openshift-cicd.git"

  cluster_type        = module.dev_cluster.platform.type_code
  ingress_subdomain   = module.dev_cluster.platform.ingress
  cluster_config_file = module.dev_cluster.config_file_path
  olm_namespace       = module.dev_capture_olm_state.namespace
  operator_namespace  = module.dev_capture_operator_state.namespace
  app_namespace       = module.dev_capture_tools_state.namespace
  sealed_secret_cert  = module.cert.cert
  sealed_secret_private_key = module.cert.private_key
}
```

