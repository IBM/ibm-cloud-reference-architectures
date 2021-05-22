module "hpcs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.hpcs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.hpcs_resource_group_provision

}
module "mgmt_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.mgmt_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.mgmt_resource_group_provision

}
module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.workload_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.workload_resource_group_provision

}
module "cs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.cs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.cs_resource_group_provision

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
  tags = var.hpcs_tags == null ? null : jsondecode(var.hpcs_tags)
  number_of_crypto_units = var.hpcs_number_of_crypto_units
  provision = var.hpcs_provision
  label = var.hpcs_label

}
module "ibm-access-group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-access-group?ref=v2.2.0"

  resource_group_name = module.resource_group.name
  provision = module.resource_group.provision

}
module "ibm-activity-tracker" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.2.0"

  resource_group_name = module.cs_resource_group.name
  resource_location = var.region
  name_prefix = var.cs_name_prefix
  tags = var.ibm-activity-tracker_tags == null ? null : jsondecode(var.ibm-activity-tracker_tags)
  plan = var.ibm-activity-tracker_plan
  provision = var.ibm-activity-tracker_provision
  label = var.ibm-activity-tracker_label

}
module "ibm-flow-logs" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-flow-log?ref=v1.0.0"

  resource_group_id = module.resource_group.id
  cos_bucket_name = module.flow_log_bucket.bucket_name
  target_count = module.ibm-vpc.count
  target_ids = module.ibm-vpc.ids
  target_names = module.ibm-vpc.names
  auth_id = var.ibm-flow-logs_auth_id
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.ibm-flow-logs_provision

}
module "kube-encrypt-auth" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-iam-service-authorization?ref=v1.1.2"

  source_service_name = var.kube-encrypt-auth_source_service_name
  source_resource_instance_id = var.kube-encrypt-auth_source_resource_instance_id
  source_resource_type = var.kube-encrypt-auth_source_resource_type
  source_resource_group_id = module.resource_group.id
  provision = module.resource_group.provision
  target_service_name = var.kube-encrypt-auth_target_service_name
  target_resource_instance_id = var.kube-encrypt-auth_target_resource_instance_id
  target_resource_type = var.kube-encrypt-auth_target_resource_type
  target_resource_group_id = module.hpcs_resource_group.id
  roles = var.kube-encrypt-auth_roles == null ? null : jsondecode(var.kube-encrypt-auth_roles)
  source_service_account = var.kube-encrypt-auth_source_service_account

}
module "kms-key" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms-key?ref=v1.2.0"

  kms_id = module.hpcs.guid
  region = module.hpcs.location
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.workload_name_prefix
  provision = var.kms-key_provision
  name = var.kms-key_name
  label = var.kms-key_label
  rotation_interval = var.kms-key_rotation_interval
  dual_auth_delete = var.kms-key_dual_auth_delete

}
module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage?ref=v3.2.0"

  resource_group_name = module.cs_resource_group.name
  name_prefix = var.cs_name_prefix
  resource_location = var.cos_resource_location
  tags = var.cos_tags == null ? null : jsondecode(var.cos_tags)
  plan = var.cos_plan
  provision = var.cos_provision
  label = var.cos_label

}
module "management-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.11.4"

  resource_group_id = module.mgmt_resource_group.id
  resource_group_name = module.mgmt_resource_group.name
  region = var.region
  name = var.management-vpc_name
  name_prefix = var.mgmt_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.management-vpc_provision
  address_prefix_count = var.management-vpc_address_prefix_count
  address_prefixes = var.management-vpc_address_prefixes == null ? null : jsondecode(var.management-vpc_address_prefixes)

}
module "ibm-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.11.4"

  resource_group_id = module.resource_group.id
  resource_group_name = module.resource_group.name
  region = var.region
  name = var.ibm-vpc_name
  name_prefix = var.workload_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.ibm-vpc_provision
  address_prefix_count = var.ibm-vpc_address_prefix_count
  address_prefixes = var.ibm-vpc_address_prefixes == null ? null : jsondecode(var.ibm-vpc_address_prefixes)

}
module "flow_log_bucket" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage-bucket?ref=v0.4.0"

  resource_group_name = module.resource_group.name
  cos_instance_id = module.cos.id
  kms_key_crn = module.kms-key.crn
  activity_tracker_crn = module.ibm-activity-tracker.crn
  metrics_monitoring_crn = module.sysdig.crn
  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
  name_prefix = var.workload_name_prefix
  provision = var.flow_log_bucket_provision
  name = var.flow_log_bucket_name
  label = var.flow_log_bucket_label
  cross_region_location = var.cross_region_location
  storage_class = var.flow_log_bucket_storage_class

}
module "ibm-vpc-gateways" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-gateways?ref=v1.4.0"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key

}
module "workload_ssh_bastion" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh?ref=v1.5.1"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.workload_name_prefix
  name = var.workload_ssh_bastion_name
  label = var.workload_ssh_bastion_label
  public_key = var.workload_ssh_bastion_public_key
  private_key = var.workload_ssh_bastion_private_key
  public_key_file = var.workload_ssh_bastion_public_key_file
  private_key_file = var.workload_ssh_bastion_private_key_file
  rsa_bits = var.workload_ssh_bastion_rsa_bits

}
module "workload_ssh_scc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh?ref=v1.5.1"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.workload_name_prefix
  name = var.workload_ssh_scc_name
  label = var.workload_ssh_scc_label
  public_key = var.workload_ssh_scc_public_key
  private_key = var.workload_ssh_scc_private_key
  public_key_file = var.workload_ssh_scc_public_key_file
  private_key_file = var.workload_ssh_scc_private_key_file
  rsa_bits = var.workload_ssh_scc_rsa_bits

}
module "worker-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.6.2"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.worker-subnets__count
  label = var.worker-subnets_label
  zone_offset = var.worker-subnets_zone_offset
  ipv4_cidr_blocks = var.worker-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.worker-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.worker-subnets_ipv4_address_count
  provision = var.worker-subnets_provision
  acl_rules = var.worker-subnets_acl_rules == null ? null : jsondecode(var.worker-subnets_acl_rules)

}
module "vpe-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.6.2"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.vpe-subnets_gateways == null ? null : jsondecode(var.vpe-subnets_gateways)
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.vpe-subnets__count
  label = var.vpe-subnets_label
  zone_offset = var.vpe-subnets_zone_offset
  ipv4_cidr_blocks = var.vpe-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.vpe-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.vpe-subnets_ipv4_address_count
  provision = var.vpe-subnets_provision
  acl_rules = var.vpe-subnets_acl_rules == null ? null : jsondecode(var.vpe-subnets_acl_rules)

}
module "bastion-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.6.2"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.bastion-subnets_gateways == null ? null : jsondecode(var.bastion-subnets_gateways)
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.bastion-subnets__count
  label = var.bastion-subnets_label
  zone_offset = var.bastion-subnets_zone_offset
  ipv4_cidr_blocks = var.bastion-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.bastion-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.bastion-subnets_ipv4_address_count
  provision = var.bastion-subnets_provision
  acl_rules = var.bastion-subnets_acl_rules == null ? null : jsondecode(var.bastion-subnets_acl_rules)

}
module "scc-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.6.2"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.scc-subnets__count
  label = var.scc-subnets_label
  zone_offset = var.scc-subnets_zone_offset
  ipv4_cidr_blocks = var.scc-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.scc-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.scc-subnets_ipv4_address_count
  provision = var.scc-subnets_provision
  acl_rules = var.scc-subnets_acl_rules == null ? null : jsondecode(var.scc-subnets_acl_rules)

}
module "vpe-cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpe-gateway?ref=v1.2.3"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.workload_name_prefix
  vpc_id = module.ibm-vpc.id
  vpc_subnets = module.vpe-subnets.subnets
  vpc_subnet_count = module.vpe-subnets.count
  resource_crn = module.cos.crn
  resource_service = module.cos.service
  resource_label = module.cos.label

}
module "scc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-scc-collector?ref=v1.5.2"

  resource_group_id = module.resource_group.id
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  vpc_name = module.ibm-vpc.name
  base_security_group = module.ibm-vpc.base_security_group
  vpc_subnet_count = module.scc-subnets.count
  vpc_subnets = module.scc-subnets.subnets
  ssh_key_id = module.workload_ssh_scc.id
  ssh_private_key = module.workload_ssh_scc.private_key
  kms_key_crn = module.kms-key.crn
  kms_enabled = var.scc_kms_enabled
  image_name = var.scc_image_name
  init_script = var.scc_init_script

}
module "sysdig" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-sysdig?ref=v3.4.0"

  resource_group_name = module.cs_resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  plan = var.sysdig_plan
  tags = var.sysdig_tags == null ? null : jsondecode(var.sysdig_tags)
  provision = var.sysdig_provision
  name = var.sysdig_name
  label = var.sysdig_label

}
module "vsi-bastion" {
  source = "github.com/cloud-native-toolkit/terraform-vsi-bastion?ref=v1.6.0"

  vpc_name = module.ibm-vpc.name
  base_security_group = module.ibm-vpc.base_security_group
  vpc_subnet_count = module.bastion-subnets.count
  vpc_subnets = module.bastion-subnets.subnets
  resource_group_id = module.resource_group.id
  ssh_key_id = module.workload_ssh_bastion.id
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  tags = var.vsi-bastion_tags == null ? null : jsondecode(var.vsi-bastion_tags)
  kms_key_crn = module.kms-key.crn
  label = var.vsi-bastion_label
  image_name = var.vsi-bastion_image_name
  profile_name = var.vsi-bastion_profile_name
  allow_ssh_from = var.vsi-bastion_allow_ssh_from
  create_public_ip = var.vsi-bastion_create_public_ip
  init_script = var.vsi-bastion_init_script
  kms_enabled = var.vsi-bastion_kms_enabled
  auto_delete_volume = var.vsi-bastion_auto_delete_volume

}
module "ibm-transit-gateway" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-transit-gateway?ref=v0.1.0"

  resource_group_name = module.resource_group.name
  connections = [module.management-vpc.crn,module.ibm-vpc.crn]
  region = var.region
  name = var.ibm-transit-gateway_name
  name_prefix = var.workload_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key

}
