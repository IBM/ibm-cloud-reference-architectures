# Activity Tracker terraform module

Terraform module to provision Activity Tracker on IBM Cloud

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v12

### Terraform providers

- IBM Cloud provider >= 1.5.3

## Module dependencies

None

## Example usage

```hcl-terraform
module "dev_activity-tracker" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-activity-tracker?ref=v1.0.0"

  resource_group_name = var.resource_group_name
  resource_location   = var.region
  tags                = []
  name_prefix         = var.name_prefix
  plan                = "7-day"             
}
```

