# IBM Flow Logs

Module to provision flow logs for the provided resource. The target resource can be Virtual Private Cloud (VPC) instances, VPC Subnets, or VPC Virtual Server Instances. A Flow Log requires the target resource id and a Object Storage bucket where the logs will be written.

Before creating the Flow Log, the Flog Log service must be authorized with "Writer" access to the Object Storage service. **Note**: For whatever reason, the authorization cannot be scoped for resource group to resource group. Here is an example authorization using the `github.com/cloud-native-services/terraform-ibm-iam-service-authorization` module:

```hcl
module "flow_log_auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization"

  source_service_name = "is"
  source_resource_type = "flow-log-collector"
  provision = true
  target_service_name = "cloud-object-storage"
  target_resource_group_id = module.resource_group.id
  roles = ["Writer"]
}
```

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.23.0

## Module dependencies

This module makes use of the output from other modules:

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group.git
- Cos Bucket - github.com/cloud-native-toolkit/terraform-ibm-object-storage-bucket.git
- Target resource - (Interface) github.com/cloud-native-toolkit/garage-terraform-modules#ibm-vpc-resource
- Service Authorization (optional) - github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization.git

## Example usage

[Refer test cases for more details](test/stages/stage2-flow-log.tf)

```hcl-terraform
module "flow_log" {
  module = "github.com/cloud-native-toolkit/terraform-ibm-flow-log.git"

  region            = var.region
  ibmcloud_api_key  = var.ibmcloud_api_key
  resource_group_id = module.resource_group.id
  cos_bucket_name   = module.cos_bucket.bucket_name
  target_count      = module.vpc.count
  target_ids        = module.vpc.ids
  target_names      = module.vpc.names
  auth_id           = module.flow_log_auth.id
}
```
