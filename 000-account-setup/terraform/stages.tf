module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.at_resource_group_name
  sync = var.resource_group_sync
  provision = var.at_resource_group_provision
}
module "at-us-east" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.4.0"

  resource_group_name = module.resource_group.name
  resource_location = var.at-us-east_region
  tags = var.at-us-east_tags == null ? null : jsondecode(var.at-us-east_tags)
  plan = var.at-us-east_plan
  provision = var.at-us-east_provision
}
module "at-us-south" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.4.0"

  resource_group_name = module.resource_group.name
  resource_location = var.at-us-south_region
  tags = var.at-us-south_tags == null ? null : jsondecode(var.at-us-south_tags)
  plan = var.at-us-south_plan
  provision = var.at-us-south_provision
}
module "at-eu-de" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.4.0"

  resource_group_name = module.resource_group.name
  resource_location = var.at-eu-de_region
  tags = var.at-eu-de_tags == null ? null : jsondecode(var.at-eu-de_tags)
  plan = var.at-eu-de_plan
  provision = var.at-eu-de_provision
}
module "at-eu-gb" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.4.0"

  resource_group_name = module.resource_group.name
  resource_location = var.at-eu-gb_region
  tags = var.at-eu-gb_tags == null ? null : jsondecode(var.at-eu-gb_tags)
  plan = var.at-eu-gb_plan
  provision = var.at-eu-gb_provision
}
module "ibm-onboard-fs-account" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-onboard-fs-account?ref=v1.1.0"

  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
  action = var.ibm-onboard-fs-account_action
  mfa = var.ibm-onboard-fs-account_mfa
  restrict_create_service_id = var.ibm-onboard-fs-account_restrict_create_service_id
  restrict_create_platform_apikey = var.ibm-onboard-fs-account_restrict_create_platform_apikey
}
