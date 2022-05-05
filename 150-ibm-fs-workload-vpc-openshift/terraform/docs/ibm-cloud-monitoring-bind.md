# IBM Cloud Monitoring bind module

Module to connect an existing IBM Cloud Monitoring instance to a cluster. The cluster is attached via the IBM Cloud cli and as a result the Connect/Disconnect button state will be updated to reflect the current status of the deployed agents.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v0.13

### Terraform providers

- IBM Cloud provider >= 1.5.3

## Module dependencies

This module makes use of the output from other modules:

- Cluster - any module that implements the github.com/cloud-native-toolkit/automation-modules#cluster interface
- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group
- IBM Cloud Monitoring - github.com/cloud-native-toolkit/terraform-ibm-cloud-monitoring

## Example usage

```hcl-terraform
module "cloud_monitoring_bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-cloud-monitoring-bind.git"
  
  region                   = var.region
  ibmcloud_api_key         = var.ibmcloud_api_key
  resource_group_name      = module.resource_group.name
  guid                     = module.cloud_monitoring.guid
  access_key               = module.cloud_monitoring.access_key
  cluster_name             = module.dev_cluster.name
  cluster_id               = module.dev_cluster.id
  private_endpoint         = "false"
}
```

