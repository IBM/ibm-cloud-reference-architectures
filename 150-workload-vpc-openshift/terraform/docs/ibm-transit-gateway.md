# Transit Gateway terraform module

Provisions a transit gateway instance and creates connections to vpc instances.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

## Example usage

```
terraform {
  required_providers {
    ibm = {
      source = "ibm-cloud/ibm"
    }
  }
  required_version = ">= 0.13"
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
}

module "transit_gateway" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-transit-gateway"
  
  resource_group_name = module.resource_group.name
  region              = var.region
  connections         = [
    ibm_is_vpc.vpc1.resource_crn, 
    ibm_is_vpc.vpc2.resource_crn, 
    ibm_is_vpc.vpc3.resource_crn, 
  ]
}
```

The `connections` field is a `list(string)` of resource CRNs for specific VPC instances.   The example above references vpc instances in the same terraform template, but could also be in a string format:

```
module "transit_gateway" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-transit-gateway"
  
  resource_group_name = "my-resource-group"
  region              = "us-east"
  ibmcloud_api_key    = var.ibmcloud_api_key
  connections         = [
    "crn:v1:bluemix:public:resource-controller::a/ABCDEF0123456789ABCDEF0123456789::resource-group:ABCDEF0123456789ABCDEF0123456789",
    "crn:v1:bluemix:public:resource-controller::a/9876543210ABCDEF9876543210ABCDEF::resource-group:9876543210ABCDEF9876543210ABCDEF"
  ]
}
```

## Resources

- [IBM Cloud docs for `ibm_tg_gateway` terraform provider](https://cloud.ibm.com/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-tg-resource)
- [IBM Cloud docs for the Transit Gateway service](https://cloud.ibm.com/docs/transit-gateway?topic=transit-gateway-getting-started)
