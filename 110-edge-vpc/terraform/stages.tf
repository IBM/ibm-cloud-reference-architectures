module "kms_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.kms_resource_group_name
  sync = var.kms_resource_group_sync
  provision = var.kms_resource_group_provision
}
module "at_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.at_resource_group_name
  sync = var.at_resource_group_sync
  provision = var.at_resource_group_provision
}
module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.edge_resource_group_name
  sync = var.resource_group_sync
  provision = var.edge_resource_group_provision
}
module "cs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.cs_resource_group_name
  sync = var.cs_resource_group_sync
  provision = var.cs_resource_group_provision
}
module "ibm-access-group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-access-group?ref=v3.0.0"

  resource_group_name = module.resource_group.name
  provision = module.resource_group.provision
}
module "ibm-activity-tracker" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-activity-tracker?ref=v2.4.0"

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
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms?ref=v0.3.2"

  resource_group_name = module.kms_resource_group.name
  region = var.kms_region
  name_prefix = var.kms_name_prefix
  name = var.kms_name
  private_endpoint = var.private_endpoint
  tags = var.kms_tags == null ? null : jsondecode(var.kms_tags)
  provision = var.kms_provision
  number_of_crypto_units = var.kms_number_of_crypto_units
  service = var.kms_service
}
module "kms-key" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms-key?ref=v1.5.0"

  kms_id = module.kms.guid
  kms_public_url = module.kms.public_url
  kms_private_url = module.kms.private_url
  name_prefix = var.edge_name_prefix
  provision = var.kms-key_provision
  name = var.kms-key_name
  label = var.kms-key_label
  rotation_interval = var.kms-key_rotation_interval
  dual_auth_delete = var.kms-key_dual_auth_delete
  force_delete = var.kms-key_force_delete
}
module "ibm-cert-manager" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-cert-manager?ref=v1.1.0"

  resource_group_name = module.cs_resource_group.name
  kms_id = module.kms-key.kms_id
  kms_key_crn = module.kms-key.crn
  kms_private_url = module.kms-key.kms_private_url
  kms_public_url = module.kms-key.kms_public_url
  region = var.region
  name_prefix = var.cs_name_prefix
  provision = var.ibm-cert-manager_provision
  kms_enabled = var.ibm-cert-manager_kms_enabled
  kms_private_endpoint = var.ibm-cert-manager_kms_private_endpoint
  name = var.ibm-cert-manager_name
  label = var.ibm-cert-manager_label
  private_endpoint = var.ibm-cert-manager_private_endpoint
}
module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage?ref=v4.0.0"

  resource_group_name = module.cs_resource_group.name
  name_prefix = var.cs_name_prefix
  resource_location = var.cos_resource_location
  tags = var.cos_tags == null ? null : jsondecode(var.cos_tags)
  plan = var.cos_plan
  provision = var.cos_provision
  label = var.cos_label
}
module "ibm-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.13.0"

  resource_group_id = module.resource_group.id
  resource_group_name = module.resource_group.name
  region = var.region
  name = var.ibm-vpc_name
  name_prefix = var.edge_name_prefix
  provision = var.ibm-vpc_provision
  address_prefix_count = var.ibm-vpc_address_prefix_count
  address_prefixes = var.ibm-vpc_address_prefixes == null ? null : jsondecode(var.ibm-vpc_address_prefixes)
  base_security_group_name = var.ibm-vpc_base_security_group_name
  internal_cidr = var.ibm-vpc_internal_cidr
}
module "flow_log_bucket" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage-bucket?ref=v0.8.2"

  resource_group_name = module.resource_group.name
  cos_instance_id = module.cos.id
  cos_key_id = module.cos.key_id
  kms_key_crn = module.kms-key.crn
  activity_tracker_crn = module.ibm-activity-tracker.crn
  metrics_monitoring_crn = module.sysdig.crn
  vpc_ip_addresses = module.ibm-vpc.addresses
  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
  name_prefix = var.edge_name_prefix
  suffix = var.suffix
  provision = var.flow_log_bucket_provision
  name = var.flow_log_bucket_name
  label = var.flow_log_bucket_label
  cross_region_location = var.flow_log_bucket_cross_region_location
  storage_class = var.flow_log_bucket_storage_class
  allowed_ip = var.flow_log_bucket_allowed_ip == null ? null : jsondecode(var.flow_log_bucket_allowed_ip)
}
module "ibm-vpc-gateways" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-gateways?ref=v1.6.1"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  region = var.region
  provision = var.ibm-vpc-gateways_provision
}
module "edge_ssh_bastion" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh?ref=v1.7.1"

  resource_group_name = module.resource_group.name
  name_prefix = var.edge_name_prefix
  name = var.edge_ssh_bastion_name
  label = var.edge_ssh_bastion_label
  public_key = var.edge_ssh_bastion_public_key
  private_key = var.edge_ssh_bastion_private_key
  public_key_file = var.edge_ssh_bastion_public_key_file
  private_key_file = var.edge_ssh_bastion_private_key_file
  rsa_bits = var.edge_ssh_bastion_rsa_bits
}
module "ingress-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.9.4"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  _count = var.ingress-subnets__count
  label = var.ingress-subnets_label
  zone_offset = var.ingress-subnets_zone_offset
  ipv4_cidr_blocks = var.ingress-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.ingress-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.ingress-subnets_ipv4_address_count
  provision = var.ingress-subnets_provision
  acl_rules = var.ingress-subnets_acl_rules == null ? null : jsondecode(var.ingress-subnets_acl_rules)
}
module "bastion-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.9.4"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.bastion-subnets_gateways == null ? null : jsondecode(var.bastion-subnets_gateways)
  region = var.region
  _count = var.bastion-subnets__count
  label = var.bastion-subnets_label
  zone_offset = var.bastion-subnets_zone_offset
  ipv4_cidr_blocks = var.bastion-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.bastion-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.bastion-subnets_ipv4_address_count
  provision = var.bastion-subnets_provision
  acl_rules = var.bastion-subnets_acl_rules == null ? null : jsondecode(var.bastion-subnets_acl_rules)
}
module "egress-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.9.4"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.egress-subnets_gateways == null ? null : jsondecode(var.egress-subnets_gateways)
  region = var.region
  _count = var.egress-subnets__count
  label = var.egress-subnets_label
  zone_offset = var.egress-subnets_zone_offset
  ipv4_cidr_blocks = var.egress-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.egress-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.egress-subnets_ipv4_address_count
  provision = var.egress-subnets_provision
  acl_rules = var.egress-subnets_acl_rules == null ? null : jsondecode(var.egress-subnets_acl_rules)
}
module "ibm-vpc-vpn-gateway" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpn-gateway?ref=v1.1.2"

  resource_group_id = module.resource_group.id
  vpc_name = module.ingress-subnets.vpc_name
  vpc_subnets = module.ingress-subnets.subnets
  vpc_subnet_count = module.ingress-subnets.count
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  label = var.ibm-vpc-vpn-gateway_label
  mode = var.ibm-vpc-vpn-gateway_mode
  tags = var.ibm-vpc-vpn-gateway_tags == null ? null : jsondecode(var.ibm-vpc-vpn-gateway_tags)
  provision = var.ibm-vpc-vpn-gateway_provision
}
module "ibm-vpn-server" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpn-server?ref=v0.0.11"

  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
  resource_label = var.ibm-vpn-server_resource_label
  resource_group_name = module.resource_group.name
  certificate_manager_id = module.ibm-cert-manager.id
  vpc_id = module.ingress-subnets.vpc_id
  subnet_ids = module.ingress-subnets.ids
  name_prefix = var.edge_name_prefix
  vpnclient_ip = var.ibm-vpn-server_vpnclient_ip
  client_dns = var.ibm-vpn-server_client_dns == null ? null : jsondecode(var.ibm-vpn-server_client_dns)
  auth_method = var.ibm-vpn-server_auth_method
  vpn_server_proto = var.ibm-vpn-server_vpn_server_proto
  vpn_server_port = var.ibm-vpn-server_vpn_server_port
  vpn_client_timeout = var.ibm-vpn-server_vpn_client_timeout
  enable_split_tunnel = var.ibm-vpn-server_enable_split_tunnel
}
module "sysdig" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-sysdig?ref=v4.0.1"

  resource_group_name = module.cs_resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  plan = var.sysdig_plan
  tags = var.sysdig_tags == null ? null : jsondecode(var.sysdig_tags)
  provision = var.sysdig_provision
  name = var.sysdig_name
  label = var.sysdig_label
}
module "vsi-bastion" {
  source = "github.com/cloud-native-toolkit/terraform-vsi-bastion?ref=v1.9.0"

  vpc_name = module.ibm-vpc.name
  base_security_group = module.ibm-vpc.base_security_group
  vpc_subnet_count = module.bastion-subnets.count
  vpc_subnets = module.bastion-subnets.subnets
  resource_group_id = module.resource_group.id
  ssh_key_id = module.edge_ssh_bastion.id
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
  acl_rules = var.vsi-bastion_acl_rules == null ? null : jsondecode(var.vsi-bastion_acl_rules)
  target_network_range = var.vsi-bastion_target_network_range
}
module "ibm-transit-gateway" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-transit-gateway?ref=v0.2.2"

  resource_group_name = module.cs_resource_group.name
  connections = [module.ibm-vpc.crn]
  region = var.region
  name = var.ibm-transit-gateway_name
  name_prefix = var.cs_name_prefix
  provision = var.ibm-transit-gateway_provision
}
