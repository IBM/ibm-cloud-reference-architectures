# Artifactory terraform module

![Verify and release module](https://github.com/ibm-garage-cloud/terraform-tools-artifactory/workflows/Verify%20and%20release%20module/badge.svg?branch=master)

Installs Artifactory in the cluster using the helm chart.

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

## Suggested companion modules

The module itself requires some information from the cluster and needs a
namespace and service account to have been created. The following companion
modules can help provide the required information:

- Cluster - https://github.com/ibm-garage-cloud/terraform-ibm-container-platform
- Namespace - https://github.com/ibm-garage-cloud/terraform-k8s-namespace
- Dashboard - https://github.com/ibm-garage-cloud/terraform-tools-dashboard

## Example usage

```hcl-terraform
module "dev_tools_artifactory" {
  source = "github.com/ibm-garage-cloud/terraform-tools-artifactory.git?ref=v1.6.4"

  cluster_type             = module.dev_cluster.type_code
  cluster_ingress_hostname = module.dev_cluster.ingress_hostname
  cluster_config_file      = module.dev_cluster.config_file_path
  tls_secret_name          = module.dev_cluster.tls_secret_name
  releases_namespace       = module.dev_tools_namespace.name
  icon_url                 = module.dev_dashboard.base_icon_url
}
```
