# Developer Dashboard terraform module

![Verify and release module](https://github.com/ibm-garage-cloud/terraform-tools-dashboard/workflows/Verify%20and%20release%20module/badge.svg)

Installs the Cloud-Native Toolkit Developer Dashboard into the cluster.

## Supported platforms

This module supports the following Kubernetes distros

- Kubernetes 1.17+
- OCP 4.3+

## Module dependencies

- Cluster
- Namespace

## Software dependencies

- kubectl
- helm terraform provider (provided by the terraform infrastructure)

## Example usage

```hcl-terraform
module "dev_tools_dashboard" {
  source = "github.com/ibm-garage-cloud/teraform-tools-dashboard?ref=v1.1.0"

  cluster_ingress_hostname = module.dev_cluster.ingress_hostname
  cluster_config_file      = module.dev_cluster.config_file_path
  cluster_type             = module.dev_cluster.cluster_type
  tls_secret_name          = module.dev_cluster.tls_secret_name
  releases_namespace       = module.dev_cluster_namespaces.tools_namespace_name
  image_tag                = "1.0.31"
}
```
