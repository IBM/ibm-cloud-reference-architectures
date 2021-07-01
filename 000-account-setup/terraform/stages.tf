module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.hpcs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.hpcs_resource_group_provision

}
module "hpcs" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-hpcs?ref=v1.2.1"

  resource_group_name = module.resource_group.name
  region = var.hpcs_region
  name_prefix = var.hpcs_name_prefix
  name = var.hpcs_name
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
  plan = var.hpcs_plan
  tags = var.hpcs_tags == null ? null : jsondecode(var.hpcs_tags)
  number_of_crypto_units = var.hpcs_number_of_crypto_units
  provision = var.hpcs_provision
  label = var.hpcs_label

}
module "at-us-east" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.3.0"

  resource_group_name = module.resource_group.name
  resource_location = var.at-us-east_region
  tags = var.at-us-east_tags == null ? null : jsondecode(var.at-us-east_tags)
  plan = var.at-us-east_plan
  provision = var.at-us-east_provision

}
module "at-us-south" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.3.0"

  resource_group_name = module.resource_group.name
  resource_location = var.at-us-south_region
  tags = var.at-us-south_tags == null ? null : jsondecode(var.at-us-south_tags)
  plan = var.at-us-south_plan
  provision = var.at-us-south_provision

}
module "at-eu-de" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.3.0"

  resource_group_name = module.resource_group.name
  resource_location = var.at-eu-de_region
  tags = var.at-eu-de_tags == null ? null : jsondecode(var.at-eu-de_tags)
  plan = var.at-eu-de_plan
  provision = var.at-eu-de_provision

}
module "at-eu-gb" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.3.0"

  resource_group_name = module.resource_group.name
  resource_location = var.at-eu-gb_region
  tags = var.at-eu-gb_tags == null ? null : jsondecode(var.at-eu-gb_tags)
  plan = var.at-eu-gb_plan
  provision = var.at-eu-gb_provision

}
module "vsi-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.1.2"

  source_service_name = var.vsi-encrypt-auth_source_service_name
  source_resource_instance_id = var.vsi-encrypt-auth_source_resource_instance_id
  source_resource_type = var.vsi-encrypt-auth_source_resource_type
  source_resource_group_id = var.vsi-encrypt-auth_source_resource_group_id
  provision = var.vsi-encrypt-auth_provision
  target_service_name = var.vsi-encrypt-auth_target_service_name
  target_resource_instance_id = var.vsi-encrypt-auth_target_resource_instance_id
  target_resource_type = var.vsi-encrypt-auth_target_resource_type
  target_resource_group_id = module.resource_group.id
  roles = var.vsi-encrypt-auth_roles == null ? null : jsondecode(var.vsi-encrypt-auth_roles)
  source_service_account = var.vsi-encrypt-auth_source_service_account

}
module "cos-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.1.2"

  source_service_name = var.cos-encrypt-auth_source_service_name
  source_resource_instance_id = var.cos-encrypt-auth_source_resource_instance_id
  source_resource_type = var.cos-encrypt-auth_source_resource_type
  source_resource_group_id = var.cos-encrypt-auth_source_resource_group_id
  provision = var.cos-encrypt-auth_provision
  target_service_name = var.cos-encrypt-auth_target_service_name
  target_resource_instance_id = var.cos-encrypt-auth_target_resource_instance_id
  target_resource_type = var.cos-encrypt-auth_target_resource_type
  target_resource_group_id = module.resource_group.id
  roles = var.cos-encrypt-auth_roles == null ? null : jsondecode(var.cos-encrypt-auth_roles)
  source_service_account = var.cos-encrypt-auth_source_service_account

}
module "ibm-onboard-fs-account" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-onboard-fs-account?ref=v1.0.1"

  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
  action = var.ibm-onboard-fs-account_action
  mfa = var.ibm-onboard-fs-account_mfa
  restrict_create_service_id = var.ibm-onboard-fs-account_restrict_create_service_id
  restrict_create_platform_apikey = var.ibm-onboard-fs-account_restrict_create_platform_apikey

}
