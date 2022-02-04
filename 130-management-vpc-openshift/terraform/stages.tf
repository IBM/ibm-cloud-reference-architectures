module "kms-key" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms-key?ref=v1.5.0"

  kms_id = module.kms.guid
  kms_public_url = module.kms.public_url
  kms_private_url = module.kms.private_url
  name_prefix = var.mgmt_name_prefix
  provision = var.kms-key_provision
  name = var.kms-key_name
  label = var.kms-key_label
  rotation_interval = var.kms-key_rotation_interval
  dual_auth_delete = var.kms-key_dual_auth_delete
  force_delete = var.kms-key_force_delete
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
module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.mgmt_resource_group_name
  sync = var.resource_group_sync
  provision = var.mgmt_resource_group_provision
}
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
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc?ref=v1.10.3"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name = var.cluster_name
  worker_count = var.mgmt_worker_count
  flavor = var.cluster_flavor
  ocp_version = var.ocp_version
  exists = var.cluster_exists
  disable_public_endpoint = var.cluster_disable_public_endpoint
  name_prefix = var.mgmt_name_prefix
  ocp_entitlement = var.cluster_ocp_entitlement
  vpc_name = module.worker-subnets.vpc_name
  vpc_subnet_count = module.worker-subnets.count
  vpc_subnets = module.worker-subnets.subnets
  cos_id = module.cos.id
  kms_enabled = var.cluster_kms_enabled
  kms_id = module.kms-key.kms_id
  kms_key_id = module.kms-key.id
  kms_private_endpoint = var.cluster_kms_private_endpoint
  login = var.cluster_login
  sync = var.cluster_sync
}
module "worker-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.9.4"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  _count = var.mgmt_worker_subnet_count
  label = var.worker-subnets_label
  zone_offset = var.worker-subnets_zone_offset
  ipv4_cidr_blocks = var.worker-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.worker-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.worker-subnets_ipv4_address_count
  provision = var.worker-subnets_provision
  acl_rules = var.worker-subnets_acl_rules == null ? null : jsondecode(var.worker-subnets_acl_rules)
}
module "ibm-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.13.0"

  resource_group_id = module.resource_group.id
  resource_group_name = module.resource_group.name
  region = var.region
  name = var.ibm-vpc_name
  name_prefix = var.mgmt_name_prefix
  provision = var.ibm-vpc_provision
  address_prefix_count = var.ibm-vpc_address_prefix_count
  address_prefixes = var.ibm-vpc_address_prefixes == null ? null : jsondecode(var.ibm-vpc_address_prefixes)
  base_security_group_name = var.ibm-vpc_base_security_group_name
  internal_cidr = var.ibm-vpc_internal_cidr
}
module "sysdig-bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-sysdig-bind?ref=v1.2.3"

  resource_group_name = module.resource_group.name
  cluster_id = module.cluster.id
  cluster_name = module.cluster.name
  region = var.region
  private_endpoint = var.private_endpoint
  guid = module.sysdig.guid
  access_key = module.sysdig.access_key
  ibmcloud_api_key = var.ibmcloud_api_key
  namespace = var.sysdig-bind_namespace
  sync = var.sysdig-bind_sync
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
module "ibm-logdna-bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna-bind?ref=v1.2.3"

  cluster_id = module.cluster.id
  cluster_name = module.cluster.name
  resource_group_name = module.resource_group.name
  sync = module.sysdig-bind.sync
  logdna_id = module.logdna.guid
  region = var.region
  private_endpoint = var.private_endpoint
  ibmcloud_api_key = var.ibmcloud_api_key
}
module "logdna" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna?ref=v4.0.0"

  resource_group_name = module.cs_resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  plan = var.logdna_plan
  tags = var.logdna_tags == null ? null : jsondecode(var.logdna_tags)
  provision = var.logdna_provision
  name = var.logdna_name
  label = var.logdna_label
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
  name_prefix = var.mgmt_name_prefix
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
module "vpe-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.9.4"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.vpe-subnets_gateways == null ? null : jsondecode(var.vpe-subnets_gateways)
  region = var.region
  _count = var.vpe-subnets__count
  label = var.vpe-subnets_label
  zone_offset = var.vpe-subnets_zone_offset
  ipv4_cidr_blocks = var.vpe-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.vpe-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.vpe-subnets_ipv4_address_count
  provision = var.vpe-subnets_provision
  acl_rules = var.vpe-subnets_acl_rules == null ? null : jsondecode(var.vpe-subnets_acl_rules)
}
module "ingress-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.9.4"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.ingress-subnets_gateways == null ? null : jsondecode(var.ingress-subnets_gateways)
  region = var.region
  _count = var.ingress-subnets__count
  label = var.ingress-subnets_label
  zone_offset = var.ingress-subnets_zone_offset
  ipv4_cidr_blocks = var.ingress-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.ingress-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.ingress-subnets_ipv4_address_count
  provision = var.ingress-subnets_provision
  acl_rules = var.ingress-subnets_acl_rules == null ? null : jsondecode(var.ingress-subnets_acl_rules)
}
module "ibm-vpc-vpn-gateway" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpn-gateway?ref=v1.1.2"

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
module "vpn-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.9.4"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.vpn-subnets_gateways == null ? null : jsondecode(var.vpn-subnets_gateways)
  region = var.region
  _count = var.vpn-subnets__count
  label = var.vpn-subnets_label
  zone_offset = var.vpn-subnets_zone_offset
  ipv4_cidr_blocks = var.vpn-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.vpn-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.vpn-subnets_ipv4_address_count
  provision = var.vpn-subnets_provision
  acl_rules = var.vpn-subnets_acl_rules == null ? null : jsondecode(var.vpn-subnets_acl_rules)
}
module "vpe-cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpe-gateway?ref=v1.6.0"

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
  sync = module.cluster.sync
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
