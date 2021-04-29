module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.cs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.cs_resource_group_provision

}
module "hpcs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.hpcs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.hpcs_resource_group_provision

}
module "hpcs" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-hpcs?ref=v1.2.1"

  resource_group_name = module.hpcs_resource_group.name
  region = var.hpcs_region
  name_prefix = var.hpcs_name_prefix
  name = var.hpcs_name
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
  plan = var.hpcs_plan
  tags = tolist(setsubtract(split(",", var.hpcs_tags), [""]))
  number_of_crypto_units = var.hpcs_number_of_crypto_units
  provision = var.hpcs_provision
  label = var.hpcs_label

}
module "ibm-access-group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-access-group?ref=v2.1.1"

  resource_group_name = module.resource_group.name

}
module "ibm-activity-tracker" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.1.2"

  resource_group_name = module.resource_group.name
  resource_location = var.region
  name_prefix = var.cs_name_prefix
  tags = tolist(setsubtract(split(",", var.ibm-activity-tracker_tags), [""]))
  plan = var.ibm-activity-tracker_plan
  provision = var.ibm-activity-tracker_provision

}
module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage?ref=v3.2.0"

  resource_group_name = module.resource_group.name
  name_prefix = var.cs_name_prefix
  resource_location = var.cos_resource_location
  tags = tolist(setsubtract(split(",", var.cos_tags), [""]))
  plan = var.cos_plan
  provision = var.cos_provision
  label = var.cos_label

}
module "key-protect" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-key-protect?ref=v2.1.1"

  resource_group_name = module.resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
  tags = tolist(setsubtract(split(",", var.key-protect_tags), [""]))
  plan = var.key-protect_plan
  provision = var.key-protect_provision
  label = var.key-protect_label

}
module "logdna" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna?ref=v3.2.1"

  resource_group_name = module.resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  plan = var.logdna_plan
  tags = tolist(setsubtract(split(",", var.logdna_tags), [""]))
  provision = var.logdna_provision
  name = var.logdna_name

}
module "sysdig" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-sysdig?ref=v3.3.0"

  resource_group_name = module.resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  plan = var.sysdig_plan
  tags = tolist(setsubtract(split(",", var.sysdig_tags), [""]))
  provision = var.sysdig_provision
  name = var.sysdig_name

}
