# IAM Service Authorization

Module to create an IBM Cloud IAM Authorization Policy that authorizes one cloud service to access another. An authorization policy is requried in a number of scenarios:

- In order to encrypt the data in a hosted a **Databases for MongoDB** service with a particular key in **Key Protect**, the **Databases for MongoDB** service must be authorized with the `Reader` role to **Key Protect**.
- In order for a **VPC Flow Log** to write records to an **Object Storage** bucket, the **VPC Flow Log** service must be authorized with `Writer` access to **Object Storage**.

Authorization policies can be created at different scopes. The most specific scope is service instance to service instance (e.g. a specific **Databases for MongoDB** service instance can access a specific **Key Protect** instance. The broadest scope is service type to service type across the entire account (e.g. all **Database for MongoDB** instances in the account can access all **Key Protect** instances in the account). Authorizations can also be scoped by resource group.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.12.0

## Module dependencies

This module makes use of the output from other modules:

- Resource interface - any module implementing the resource interface for either source or target

## Example usage

[Refer test cases for more details](test/stages/stage2-service_authorization.tf)


```hcl-terraform
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

mmodule "service_authorization" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-service-authorization.git"

  source_service_name = "cloud-object-storage"
  target_service_name = "kms"
  roles = ["Reader"]
}
```

## Attribution

This module is derived from https://github.com/terraform-ibm-modules/terraform-ibm-iam/tree/main/modules/authorization-policy

