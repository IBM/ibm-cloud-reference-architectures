# SonarQube terraform module

![Verify and release module](https://github.com/ibm-garage-cloud/terraform-tools-sonarqube/workflows/Verify%20and%20release%20module/badge.svg)

Deploys SonarQube into the cluster using the helm chart. By default, a Postgres instance is deployed
into the cluster as well to support the SonarQube instance.

## Supported platforms

- IKS
- OCP 3.11
- OCP 4.3

## Module dependencies

The module uses the following elements

### Terraform providers

- helm - used to install the artifactory and artifactory-config helm charts
- null - used to run the shell script to create the route on openshift

### Environment

- kubectl - used to apply the yaml to create the route
- kustomize - used to patch the deployment with the service account

## Suggested companion modules

The module itself requires some information from the cluster and needs a
namespace and service account to have been created. The following companion
modules can help provide the required information:

- Cluster - https://github.com/ibm-garage-cloud/terraform-cluster-ibmcloud
- Namespace - https://github.com/ibm-garage-cloud/terraform-cluster-namespace
- ServiceAccount - https://github.com/ibm-garage-cloud/terraform-cluster-serviceaccount
- (optional) Postgresql - https://github.com/ibm-garage-cloud/garage-terraform-modules.git//cloud-managed/services/postgres

## Example usage

```hcl-terraform
module "dev_tools_sonarqube" {
  source = "github.com/ibm-garage-cloud/terraform-tools-sonarqube.git?ref=v1.0.0"

  cluster_type             = var.cluster_type
  cluster_ingress_hostname = module.dev_cluster.ingress_hostname
  cluster_config_file      = module.dev_cluster.config_file_path
  releases_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  service_account_name     = module.dev_serviceaccount_sonarqube.name
  tls_secret_name          = module.dev_cluster.tls_secret_name
}
```
