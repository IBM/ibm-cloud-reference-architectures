module "kms_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.4.6"

  resource_group_name = var.kms_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  sync = var.kms_resource_group_sync
  provision = var.kms_resource_group_provision

}
module "at_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.4.6"

  resource_group_name = var.at_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  sync = var.at_resource_group_sync
  provision = var.at_resource_group_provision

}
module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.4.6"

  resource_group_name = var.mgmt_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  sync = var.resource_group_sync
  provision = var.mgmt_resource_group_provision

}
module "cs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.4.6"

  resource_group_name = var.cs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  sync = var.cs_resource_group_sync
  provision = var.cs_resource_group_provision

}
module "ibm-access-group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-access-group?ref=v2.3.0"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = module.resource_group.name
  provision = module.resource_group.provision

}
module "ibm-activity-tracker" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.3.0"

  resource_group_name = module.at_resource_group.name
  resource_location = var.region
  tags = var.ibm-activity-tracker_tags == null ? null : jsondecode(var.ibm-activity-tracker_tags)
  plan = var.ibm-activity-tracker_plan
  provision = var.ibm-activity-tracker_provision

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
module "kms-key" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms-key?ref=v1.3.0"

  kms_id = module.kms.guid
  region = module.kms.location
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.mgmt_name_prefix
  provision = var.kms-key_provision
  name = var.kms-key_name
  label = var.kms-key_label
  rotation_interval = var.kms-key_rotation_interval
  dual_auth_delete = var.kms-key_dual_auth_delete
  force_delete = var.kms-key_force_delete

}
module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage?ref=v3.3.3"

  resource_group_name = module.cs_resource_group.name
  name_prefix = var.cs_name_prefix
  resource_location = var.cos_resource_location
  tags = var.cos_tags == null ? null : jsondecode(var.cos_tags)
  plan = var.cos_plan
  provision = var.cos_provision
  label = var.cos_label

}
module "ibm-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.11.7"

  resource_group_id = module.resource_group.id
  resource_group_name = module.resource_group.name
  region = var.region
  name = var.ibm-vpc_name
  name_prefix = var.mgmt_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.ibm-vpc_provision
  address_prefix_count = var.ibm-vpc_address_prefix_count
  address_prefixes = var.ibm-vpc_address_prefixes == null ? null : jsondecode(var.ibm-vpc_address_prefixes)
  base_security_group_name = var.ibm-vpc_base_security_group_name

}
module "flow_log_bucket" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage-bucket?ref=v0.7.0"

  resource_group_name = module.resource_group.name
  cos_instance_id = module.cos.id
  cos_key_id = module.cos.key_id
  kms_key_crn = module.kms-key.crn
  activity_tracker_crn = module.ibm-activity-tracker.crn
  metrics_monitoring_crn = module.sysdig.crn
  vpc_ip_addresses = module.ibm-vpc.addresses
  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
  name_prefix = var.mgmt_name_prefix
  provision = var.flow_log_bucket_provision
  name = var.flow_log_bucket_name
  label = var.flow_log_bucket_label
  cross_region_location = var.flow_log_bucket_cross_region_location
  storage_class = var.flow_log_bucket_storage_class
  allowed_ip = var.flow_log_bucket_allowed_ip == null ? null : jsondecode(var.flow_log_bucket_allowed_ip)

}
module "ibm-vpc-gateways" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-gateways?ref=v1.5.1"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.ibm-vpc-gateways_provision

}
module "mgmt_ssh_vpn" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh?ref=v1.6.0"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.mgmt_name_prefix
  name = var.mgmt_ssh_vpn_name
  label = var.mgmt_ssh_vpn_label
  public_key = var.mgmt_ssh_vpn_public_key
  private_key = var.mgmt_ssh_vpn_private_key
  public_key_file = var.mgmt_ssh_vpn_public_key_file
  private_key_file = var.mgmt_ssh_vpn_private_key_file
  rsa_bits = var.mgmt_ssh_vpn_rsa_bits

}
module "mgmt_ssh_bastion" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh?ref=v1.6.0"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.mgmt_name_prefix
  name = var.mgmt_ssh_bastion_name
  label = var.mgmt_ssh_bastion_label
  public_key = var.mgmt_ssh_bastion_public_key
  private_key = var.mgmt_ssh_bastion_private_key
  public_key_file = var.mgmt_ssh_bastion_public_key_file
  private_key_file = var.mgmt_ssh_bastion_private_key_file
  rsa_bits = var.mgmt_ssh_bastion_rsa_bits

}
module "worker-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.8.1"

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
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.8.1"

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
module "vpn-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.8.1"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.vpn-subnets_gateways == null ? null : jsondecode(var.vpn-subnets_gateways)
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.vpn-subnets__count
  label = var.vpn-subnets_label
  zone_offset = var.vpn-subnets_zone_offset
  ipv4_cidr_blocks = var.vpn-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.vpn-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.vpn-subnets_ipv4_address_count
  provision = var.vpn-subnets_provision
  acl_rules = var.vpn-subnets_acl_rules == null ? null : jsondecode(var.vpn-subnets_acl_rules)

}
module "bastion-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.8.1"

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
module "ibm-vpc-vpn-gateway" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpn-gateway?ref=v1.1.0"

  resource_group_id = module.resource_group.id
  vpc_name = module.vpn-subnets.vpc_name
  vpc_subnets = module.vpn-subnets.subnets
  vpc_subnet_count = module.vpn-subnets.count
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  label = var.ibm-vpc-vpn-gateway_label
  mode = var.ibm-vpc-vpn-gateway_mode
  tags = var.ibm-vpc-vpn-gateway_tags == null ? null : jsondecode(var.ibm-vpc-vpn-gateway_tags)
  provision = var.ibm-vpc-vpn-gateway_provision

}
module "vpe-cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpe-gateway?ref=v1.5.0"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.mgmt_name_prefix
  vpc_id = module.vpe-subnets.vpc_id
  vpc_subnets = module.vpe-subnets.subnets
  vpc_subnet_count = module.vpe-subnets.count
  resource_crn = module.cos.crn
  resource_service = module.cos.service
  resource_label = module.cos.label
  sync = var.vpe-cos_sync

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
  source = "github.com/cloud-native-toolkit/terraform-vsi-bastion?ref=v1.7.1"

  vpc_name = module.ibm-vpc.name
  base_security_group = module.ibm-vpc.base_security_group
  vpc_subnet_count = module.bastion-subnets.count
  vpc_subnets = module.bastion-subnets.subnets
  resource_group_id = module.resource_group.id
  ssh_key_id = module.mgmt_ssh_bastion.id
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
  acl_rules = var.vsi-bastion_acl_rules

}
module "vsi-vpn" {
  source = "github.com/cloud-native-toolkit/terraform-vsi-vpn?ref=v1.7.0"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  base_security_group = module.ibm-vpc.base_security_group
  subnet_count = module.vpn-subnets.count
  subnets = module.vpn-subnets.subnets
  ssh_key_id = module.mgmt_ssh_vpn.id
  ssh_private_key = module.mgmt_ssh_vpn.private_key
  instance_count = module.vsi-bastion.instance_count
  instance_network_ids = module.vsi-bastion.network_interface_ids
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  tags = var.vsi-vpn_tags == null ? null : jsondecode(var.vsi-vpn_tags)
  kms_key_crn = module.kms-key.crn
  kms_enabled = var.vsi-vpn_kms_enabled
  allow_deprecated_image = var.vsi-vpn_allow_deprecated_image

}
