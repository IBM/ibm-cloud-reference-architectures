module "at_resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.2.13"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = var.at_resource_group_name
  sync = module.kms_resource_group.sync
}
module "at-ibm-activity-tracker" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.4.12"

  ibmcloud_api_key = var.ibmcloud_api_key
  plan = var.at-ibm-activity-tracker_plan
  resource_group_name = module.resource_group.name
  resource_location = var.kms_region
  sync = module.ibm-activity-tracker.sync
  tags = var.at-ibm-activity-tracker_tags == null ? null : jsondecode(var.at-ibm-activity-tracker_tags)
}
module "cos" {
  source = "cloud-native-toolkit/object-storage/ibm"
  version = "4.0.3"

  label = var.cos_label
  name_prefix = var.cs_name_prefix
  plan = var.cos_plan
  provision = var.cos_provision
  resource_group_name = module.resource_group.name
  resource_location = var.cos_resource_location
  tags = var.cos_tags == null ? null : jsondecode(var.cos_tags)
}
module "cos-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.9"

  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.cos-encrypt-auth_provision
  roles = var.cos-encrypt-auth_roles == null ? null : jsondecode(var.cos-encrypt-auth_roles)
  source_instance = var.cos-encrypt-auth_source_instance
  source_resource_group_id = var.cos-encrypt-auth_source_resource_group_id
  source_resource_instance_id = module.cos.id
  source_resource_type = module.cos.type
  source_service_account = var.cos-encrypt-auth_source_service_account
  source_service_name = module.cos.service
  target_instance = var.cos-encrypt-auth_target_instance
  target_resource_group_id = module.kms_resource_group.id
  target_resource_instance_id = module.kms.id
  target_resource_type = module.kms.type
  target_service_name = module.kms.service
}
module "flow-log-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.9"

  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.flow-log-auth_provision
  roles = var.flow-log-auth_roles == null ? null : jsondecode(var.flow-log-auth_roles)
  source_instance = var.flow-log-auth_source_instance
  source_resource_group_id = var.flow-log-auth_source_resource_group_id
  source_resource_instance_id = var.flow-log-auth_source_resource_instance_id
  source_resource_type = var.flow-log-auth_source_resource_type
  source_service_account = var.flow-log-auth_source_service_account
  source_service_name = var.flow-log-auth_source_service_name
  target_instance = var.flow-log-auth_target_instance
  target_resource_group_id = module.resource_group.id
  target_resource_instance_id = module.cos.id
  target_resource_type = module.cos.type
  target_service_name = module.cos.service
}
module "ibm-access-group" {
  source = "cloud-native-toolkit/access-group/ibm"
  version = "3.1.2"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = module.resource_group.name
}
module "ibm-activity-tracker" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.4.12"

  ibmcloud_api_key = var.ibmcloud_api_key
  plan = var.ibm-activity-tracker_plan
  resource_group_name = module.resource_group.name
  resource_location = var.region
  sync = var.ibm-activity-tracker_sync
  tags = var.ibm-activity-tracker_tags == null ? null : jsondecode(var.ibm-activity-tracker_tags)
}
module "ibm-cert-manager" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-cert-manager?ref=v1.1.0"

  kms_enabled = var.ibm-cert-manager_kms_enabled
  kms_id = var.ibm-cert-manager_kms_id
  kms_key_crn = var.ibm-cert-manager_kms_key_crn
  kms_private_endpoint = var.ibm-cert-manager_kms_private_endpoint
  kms_private_url = var.ibm-cert-manager_kms_private_url
  kms_public_url = var.ibm-cert-manager_kms_public_url
  label = var.ibm-cert-manager_label
  name = var.ibm-cert-manager_name
  name_prefix = var.cs_name_prefix
  private_endpoint = var.ibm-cert-manager_private_endpoint
  provision = var.ibm-cert-manager_provision
  region = var.region
  resource_group_name = module.resource_group.name
}
module "kms" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms?ref=v0.3.4"

  name = var.kms_name
  name_prefix = var.kms_name_prefix
  number_of_crypto_units = var.kms_number_of_crypto_units
  private_endpoint = var.private_endpoint
  provision = var.kms_provision
  region = var.kms_region
  resource_group_name = module.kms_resource_group.name
  service = var.kms_service
  tags = var.kms_tags == null ? null : jsondecode(var.kms_tags)
}
module "kms_resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.2.13"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = var.kms_resource_group_name
  sync = module.resource_group.sync
}
module "kube-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.9"

  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.kube-encrypt-auth_provision
  roles = var.kube-encrypt-auth_roles == null ? null : jsondecode(var.kube-encrypt-auth_roles)
  source_instance = var.kube-encrypt-auth_source_instance
  source_resource_group_id = module.resource_group.id
  source_resource_instance_id = var.kube-encrypt-auth_source_resource_instance_id
  source_resource_type = var.kube-encrypt-auth_source_resource_type
  source_service_account = var.kube-encrypt-auth_source_service_account
  source_service_name = var.kube-encrypt-auth_source_service_name
  target_instance = var.kube-encrypt-auth_target_instance
  target_resource_group_id = module.kms_resource_group.id
  target_resource_instance_id = module.kms.id
  target_resource_type = module.kms.type
  target_service_name = module.kms.service
}
module "logdna" {
  source = "cloud-native-toolkit/log-analysis/ibm"
  version = "4.1.2"

  label = var.logdna_label
  name = var.logdna_name
  name_prefix = var.cs_name_prefix
  plan = var.logdna_plan
  provision = var.logdna_provision
  region = var.region
  resource_group_name = module.resource_group.name
  tags = var.logdna_tags == null ? null : jsondecode(var.logdna_tags)
}
module "resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.2.13"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = var.cs_resource_group_name
  sync = var.resource_group_sync
}
module "sysdig" {
  source = "cloud-native-toolkit/cloud-monitoring/ibm"
  version = "4.1.2"

  label = var.sysdig_label
  name = var.sysdig_name
  name_prefix = var.cs_name_prefix
  plan = var.sysdig_plan
  provision = var.sysdig_provision
  region = var.region
  resource_group_name = module.resource_group.name
  tags = var.sysdig_tags == null ? null : jsondecode(var.sysdig_tags)
}
module "vpn-cert-manager-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.9"

  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.vpn-cert-manager-auth_provision
  roles = var.vpn-cert-manager-auth_roles == null ? null : jsondecode(var.vpn-cert-manager-auth_roles)
  source_instance = var.vpn-cert-manager-auth_source_instance
  source_resource_group_id = var.vpn-cert-manager-auth_source_resource_group_id
  source_resource_instance_id = var.vpn-cert-manager-auth_source_resource_instance_id
  source_resource_type = var.vpn-cert-manager-auth_source_resource_type
  source_service_account = var.vpn-cert-manager-auth_source_service_account
  source_service_name = var.vpn-cert-manager-auth_source_service_name
  target_instance = var.vpn-cert-manager-auth_target_instance
  target_resource_group_id = var.vpn-cert-manager-auth_target_resource_group_id
  target_resource_instance_id = var.vpn-cert-manager-auth_target_resource_instance_id
  target_resource_type = var.vpn-cert-manager-auth_target_resource_type
  target_service_name = var.vpn-cert-manager-auth_target_service_name
}
module "vsi-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.9"

  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.vsi-encrypt-auth_provision
  roles = var.vsi-encrypt-auth_roles == null ? null : jsondecode(var.vsi-encrypt-auth_roles)
  source_instance = var.vsi-encrypt-auth_source_instance
  source_resource_group_id = var.vsi-encrypt-auth_source_resource_group_id
  source_resource_instance_id = var.vsi-encrypt-auth_source_resource_instance_id
  source_resource_type = var.vsi-encrypt-auth_source_resource_type
  source_service_account = var.vsi-encrypt-auth_source_service_account
  source_service_name = var.vsi-encrypt-auth_source_service_name
  target_instance = var.vsi-encrypt-auth_target_instance
  target_resource_group_id = module.kms_resource_group.id
  target_resource_instance_id = module.kms.id
  target_resource_type = module.kms.type
  target_service_name = module.kms.service
}
module "vsi-encrypt-auth1" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.9"

  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.vsi-encrypt-auth1_provision
  roles = var.vsi-encrypt-auth1_roles == null ? null : jsondecode(var.vsi-encrypt-auth1_roles)
  source_instance = var.vsi-encrypt-auth1_source_instance
  source_resource_group_id = module.resource_group.id
  source_resource_instance_id = var.vsi-encrypt-auth1_source_resource_instance_id
  source_resource_type = var.vsi-encrypt-auth1_source_resource_type
  source_service_account = var.vsi-encrypt-auth1_source_service_account
  source_service_name = var.vsi-encrypt-auth1_source_service_name
  target_instance = var.vsi-encrypt-auth1_target_instance
  target_resource_group_id = module.kms_resource_group.id
  target_resource_instance_id = module.kms.id
  target_resource_type = module.kms.type
  target_service_name = module.kms.service
}
