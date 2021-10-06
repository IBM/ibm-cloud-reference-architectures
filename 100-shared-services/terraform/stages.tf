module "vsi-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.0"

  source_service_name = var.vsi-encrypt-auth_source_service_name
  source_resource_instance_id = var.vsi-encrypt-auth_source_resource_instance_id
  source_resource_type = var.vsi-encrypt-auth_source_resource_type
  source_resource_group_id = var.vsi-encrypt-auth_source_resource_group_id
  provision = var.vsi-encrypt-auth_provision
  target_service_name = module.kms.service
  target_resource_instance_id = module.kms.id
  target_resource_type = module.kms.type
  target_resource_group_id = module.kms_resource_group.id
  roles = var.vsi-encrypt-auth_roles == null ? null : jsondecode(var.vsi-encrypt-auth_roles)
  source_service_account = var.vsi-encrypt-auth_source_service_account
  source_instance = var.vsi-encrypt-auth_source_instance
  target_instance = var.vsi-encrypt-auth_target_instance

}
module "cos-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.0"

  source_service_name = module.cos.service
  source_resource_instance_id = module.cos.id
  source_resource_type = module.cos.type
  source_resource_group_id = var.cos-encrypt-auth_source_resource_group_id
  provision = var.cos-encrypt-auth_provision
  target_service_name = module.kms.service
  target_resource_instance_id = module.kms.id
  target_resource_type = module.kms.type
  target_resource_group_id = module.kms_resource_group.id
  roles = var.cos-encrypt-auth_roles == null ? null : jsondecode(var.cos-encrypt-auth_roles)
  source_service_account = var.cos-encrypt-auth_source_service_account
  source_instance = var.cos-encrypt-auth_source_instance
  target_instance = var.cos-encrypt-auth_target_instance

}
module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.4.6"

  resource_group_name = var.cs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  sync = var.resource_group_sync
  provision = var.cs_resource_group_provision

}
module "kms_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.4.6"

  resource_group_name = var.kms_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  sync = module.resource_group.sync
  provision = var.kms_resource_group_provision

}
module "ibm-access-group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-access-group?ref=v2.3.0"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = module.resource_group.name
  provision = module.resource_group.provision

}
module "flow-log-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.0"

  source_service_name = var.flow-log-auth_source_service_name
  source_resource_instance_id = var.flow-log-auth_source_resource_instance_id
  source_resource_type = var.flow-log-auth_source_resource_type
  source_resource_group_id = var.flow-log-auth_source_resource_group_id
  provision = var.flow-log-auth_provision
  target_service_name = module.cos.service
  target_resource_instance_id = module.cos.id
  target_resource_type = module.cos.type
  target_resource_group_id = module.resource_group.id
  roles = var.flow-log-auth_roles == null ? null : jsondecode(var.flow-log-auth_roles)
  source_service_account = var.flow-log-auth_source_service_account
  source_instance = var.flow-log-auth_source_instance
  target_instance = var.flow-log-auth_target_instance

}
module "vsi-encrypt-auth1" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.0"

  source_service_name = var.vsi-encrypt-auth1_source_service_name
  source_resource_instance_id = var.vsi-encrypt-auth1_source_resource_instance_id
  source_resource_type = var.vsi-encrypt-auth1_source_resource_type
  source_resource_group_id = module.resource_group.id
  provision = module.resource_group.provision
  target_service_name = module.kms.service
  target_resource_instance_id = module.kms.id
  target_resource_type = module.kms.type
  target_resource_group_id = module.kms_resource_group.id
  roles = var.vsi-encrypt-auth1_roles == null ? null : jsondecode(var.vsi-encrypt-auth1_roles)
  source_service_account = var.vsi-encrypt-auth1_source_service_account
  source_instance = var.vsi-encrypt-auth1_source_instance
  target_instance = var.vsi-encrypt-auth1_target_instance

}
module "kube-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.2.0"

  source_service_name = var.kube-encrypt-auth_source_service_name
  source_resource_instance_id = var.kube-encrypt-auth_source_resource_instance_id
  source_resource_type = var.kube-encrypt-auth_source_resource_type
  source_resource_group_id = module.resource_group.id
  provision = module.resource_group.provision
  target_service_name = module.kms.service
  target_resource_instance_id = module.kms.id
  target_resource_type = module.kms.type
  target_resource_group_id = module.kms_resource_group.id
  roles = var.kube-encrypt-auth_roles == null ? null : jsondecode(var.kube-encrypt-auth_roles)
  source_service_account = var.kube-encrypt-auth_source_service_account
  source_instance = var.kube-encrypt-auth_source_instance
  target_instance = var.kube-encrypt-auth_target_instance

}
module "kms" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms?ref=v0.2.0"

  resource_group_name = module.kms_resource_group.name
  region = var.kms_region
  name_prefix = var.kms_name_prefix
  name = var.kms_name
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
  tags = var.kms_tags == null ? null : jsondecode(var.kms_tags)
  provision = var.kms_provision
  number_of_crypto_units = var.kms_number_of_crypto_units
  service = var.kms_service

}
module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage?ref=v3.3.3"

  resource_group_name = module.resource_group.name
  name_prefix = var.cs_name_prefix
  resource_location = var.cos_resource_location
  tags = var.cos_tags == null ? null : jsondecode(var.cos_tags)
  plan = var.cos_plan
  provision = var.cos_provision
  label = var.cos_label

}
module "logdna" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna?ref=v3.3.1"

  resource_group_name = module.resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  plan = var.logdna_plan
  tags = var.logdna_tags == null ? null : jsondecode(var.logdna_tags)
  provision = var.logdna_provision
  name = var.logdna_name
  label = var.logdna_label

}
module "sysdig" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-sysdig?ref=v3.4.0"

  resource_group_name = module.resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  plan = var.sysdig_plan
  tags = var.sysdig_tags == null ? null : jsondecode(var.sysdig_tags)
  provision = var.sysdig_provision
  name = var.sysdig_name
  label = var.sysdig_label

}
