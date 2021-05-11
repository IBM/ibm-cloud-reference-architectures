# terraform-ibm-object-storage-bucket

Provisions an IBM Cloud Object Storage instance and creates a COS bucket


## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.22.0

## Module dependencies

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group.git
- Object storage - github.com/ibm-garage-cloud/terraform-ibm-object-storage.git

## Example usage

```hcl-terraform
module "cos_bucket" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage-bucket.git"

  resource_group_name = module.resource_group.name
  cos_instance_id     = module.cos.id
  name_prefix         = var.name_prefix
  ibmcloud_api_key    = var.ibmcloud_api_key
  name                = "my-test-bucket"
  region              = var.region
  kms_key_crn         = module.hpcs_key.crn
}
```

## Attribution

This work is derivative from https://github.com/terraform-ibm-modules/terraform-ibm-cos/tree/master/modules/bucket
