module "at_resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.3.4"

  ibmcloud_api_key = var.ibmcloud_api_key
  purge_volumes = var.purge_volumes
  resource_group_name = var.at_resource_group_name
  sync = var.at_resource_group_sync
}
module "cluster" {
  source = "cloud-native-toolkit/ocp-vpc/ibm"
  version = "1.16.0"

  common_tags = var.common_tags == null ? null : jsondecode(var.common_tags)
  cos_id = module.cos.id
  disable_public_endpoint = var.cluster_disable_public_endpoint
  exists = var.cluster_exists
  flavor = var.cluster_flavor
  force_delete_storage = var.cluster_force_delete_storage
  ibmcloud_api_key = var.ibmcloud_api_key
  kms_enabled = var.cluster_kms_enabled
  kms_id = module.kms-key.kms_id
  kms_key_id = module.kms-key.id
  kms_private_endpoint = var.cluster_kms_private_endpoint
  login = var.cluster_login
  name = var.cluster_name
  name_prefix = var.workload_name_prefix
  ocp_entitlement = var.cluster_ocp_entitlement
  ocp_version = var.ocp_version
  region = var.region
  resource_group_name = module.resource_group.name
  sync = module.resource_group.sync
  tags = var.cluster_tags == null ? null : jsondecode(var.cluster_tags)
  vpc_name = module.worker-subnets.vpc_name
  vpc_subnet_count = module.worker-subnets.count
  vpc_subnets = module.worker-subnets.subnets
  worker_count = var.workload_worker_count
}
module "cos" {
  source = "cloud-native-toolkit/object-storage/ibm"
  version = "4.1.0"

  common_tags = var.common_tags == null ? null : jsondecode(var.common_tags)
  ibmcloud_api_key = var.ibmcloud_api_key
  label = var.cos_label
  name_prefix = var.cs_name_prefix
  plan = var.cos_plan
  provision = var.cos_provision
  resource_group_name = module.cs_resource_group.name
  resource_location = var.cos_resource_location
  tags = var.cos_tags == null ? null : jsondecode(var.cos_tags)
}
module "cs_resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.3.4"

  ibmcloud_api_key = var.ibmcloud_api_key
  purge_volumes = var.purge_volumes
  resource_group_name = var.cs_resource_group_name
  sync = var.cs_resource_group_sync
}
module "flow_log_bucket" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-object-storage-bucket?ref=v0.8.4"

  activity_tracker_crn = module.ibm-activity-tracker.crn
  allowed_ip = var.flow_log_bucket_allowed_ip == null ? null : jsondecode(var.flow_log_bucket_allowed_ip)
  cos_instance_id = module.cos.id
  cos_key_id = module.cos.key_id
  cross_region_location = var.flow_log_bucket_cross_region_location
  enable_object_versioning = var.flow_log_bucket_enable_object_versioning
  ibmcloud_api_key = var.ibmcloud_api_key
  kms_key_crn = module.kms-key.crn
  label = var.flow_log_bucket_label
  metrics_monitoring_crn = var.flow_log_bucket_metrics_monitoring_crn
  name = var.flow_log_bucket_name
  name_prefix = var.workload_name_prefix
  provision = var.flow_log_bucket_provision
  region = var.region
  resource_group_name = module.resource_group.name
  storage_class = var.flow_log_bucket_storage_class
  suffix = var.suffix
  vpc_ip_addresses = module.ibm-vpc.addresses
}
module "flow-log-auth" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-iam-service-authorization?ref=v1.2.14"

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
  version = "3.1.7"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = module.resource_group.name
}
module "ibm-activity-tracker" {
  source = "cloud-native-toolkit/activity-tracker/ibm"
  version = "2.4.17"

  ibmcloud_api_key = var.ibmcloud_api_key
  plan = var.ibm-activity-tracker_plan
  resource_group_name = module.at_resource_group.name
  resource_location = var.region
  sync = var.ibm-activity-tracker_sync
  tags = var.ibm-activity-tracker_tags == null ? null : jsondecode(var.ibm-activity-tracker_tags)
}
module "ibm-flow-logs" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-flow-log?ref=v1.0.3"

  auth_id = var.ibm-flow-logs_auth_id
  cos_bucket_name = module.flow_log_bucket.bucket_name
  provision = var.ibm-flow-logs_provision
  resource_group_id = module.resource_group.id
  target_count = module.ibm-vpc.count
  target_ids = module.ibm-vpc.ids
  target_names = module.ibm-vpc.names
}
module "ibm-logdna-bind" {
  source = "cloud-native-toolkit/log-analysis-bind/ibm"
  version = "1.3.6"

  cluster_id = module.cluster.id
  cluster_name = module.cluster.name
  ibmcloud_api_key = var.ibmcloud_api_key
  logdna_crn = module.logdna.id
  logdna_id = module.logdna.guid
  private_endpoint = var.private_endpoint
  region = var.region
  resource_group_name = module.resource_group.name
  sync = module.sysdig-bind.sync
}
module "ibm-transit-gateway" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-transit-gateway?ref=v0.2.3"

  connections = [module.ibm-vpc.crn]
  name = var.ibm-transit-gateway_name
  name_prefix = var.cs_name_prefix
  provision = var.ibm-transit-gateway_provision
  region = var.region
  resource_group_name = module.cs_resource_group.name
}
module "ibm-vpc" {
  source = "cloud-native-toolkit/vpc/ibm"
  version = "1.17.0"

  address_prefix_count = var.ibm-vpc_address_prefix_count
  address_prefixes = var.ibm-vpc_address_prefixes == null ? null : jsondecode(var.ibm-vpc_address_prefixes)
  base_security_group_name = var.ibm-vpc_base_security_group_name
  common_tags = var.common_tags == null ? null : jsondecode(var.common_tags)
  internal_cidr = var.ibm-vpc_internal_cidr
  name = var.ibm-vpc_name
  name_prefix = var.workload_name_prefix
  provision = var.ibm-vpc_provision
  region = var.region
  resource_group_name = module.resource_group.name
  tags = var.ibm-vpc_tags == null ? null : jsondecode(var.ibm-vpc_tags)
}
module "ibm-vpc-gateways" {
  source = "cloud-native-toolkit/vpc-gateways/ibm"
  version = "1.10.0"

  common_tags = var.common_tags == null ? null : jsondecode(var.common_tags)
  provision = var.ibm-vpc-gateways_provision
  region = var.region
  resource_group_id = module.resource_group.id
  tags = var.ibm-vpc-gateways_tags == null ? null : jsondecode(var.ibm-vpc-gateways_tags)
  vpc_name = module.ibm-vpc.name
}
module "ingress-subnets" {
  source = "cloud-native-toolkit/vpc-subnets/ibm"
  version = "1.14.0"

  _count = var.ingress-subnets__count
  acl_rules = var.ingress-subnets_acl_rules == null ? null : jsondecode(var.ingress-subnets_acl_rules)
  common_tags = var.common_tags == null ? null : jsondecode(var.common_tags)
  gateways = module.ibm-vpc-gateways.gateways
  ipv4_address_count = var.ingress-subnets_ipv4_address_count
  ipv4_cidr_blocks = var.ingress-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.ingress-subnets_ipv4_cidr_blocks)
  label = var.ingress-subnets_label
  provision = var.ingress-subnets_provision
  region = var.region
  resource_group_name = module.resource_group.name
  tags = var.ingress-subnets_tags == null ? null : jsondecode(var.ingress-subnets_tags)
  vpc_name = module.ibm-vpc.name
  zone_offset = var.ingress-subnets_zone_offset
}
module "kms" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-kms?ref=v0.3.6"

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
  version = "3.3.4"

  ibmcloud_api_key = var.ibmcloud_api_key
  purge_volumes = var.purge_volumes
  resource_group_name = var.kms_resource_group_name
  sync = var.kms_resource_group_sync
}
module "kms-key" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-kms-key?ref=v1.5.4"

  dual_auth_delete = var.kms-key_dual_auth_delete
  force_delete = var.kms-key_force_delete
  kms_id = module.kms.guid
  kms_private_url = module.kms.private_url
  kms_public_url = module.kms.public_url
  label = var.kms-key_label
  name = var.kms-key_name
  name_prefix = var.workload_name_prefix
  provision = var.kms-key_provision
  rotation_interval = var.kms-key_rotation_interval
}
module "logdna" {
  source = "cloud-native-toolkit/log-analysis/ibm"
  version = "4.1.3"

  label = var.logdna_label
  name = var.logdna_name
  name_prefix = var.cs_name_prefix
  plan = var.logdna_plan
  provision = var.logdna_provision
  region = var.region
  resource_group_name = module.cs_resource_group.name
  tags = var.logdna_tags == null ? null : jsondecode(var.logdna_tags)
}
module "resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.3.4"

  ibmcloud_api_key = var.ibmcloud_api_key
  purge_volumes = var.purge_volumes
  resource_group_name = var.workload_resource_group_name
  sync = var.resource_group_sync
}
module "sysdig" {
  source = "cloud-native-toolkit/cloud-monitoring/ibm"
  version = "4.1.3"

  label = var.sysdig_label
  name = var.sysdig_name
  name_prefix = var.cs_name_prefix
  plan = var.sysdig_plan
  provision = var.sysdig_provision
  region = var.region
  resource_group_name = module.cs_resource_group.name
  tags = var.sysdig_tags == null ? null : jsondecode(var.sysdig_tags)
}
module "sysdig-bind" {
  source = "cloud-native-toolkit/cloud-monitoring-bind/ibm"
  version = "1.3.5"

  access_key = module.sysdig.access_key
  cluster_id = module.cluster.id
  cluster_name = module.cluster.name
  guid = module.sysdig.guid
  ibmcloud_api_key = var.ibmcloud_api_key
  namespace = var.sysdig-bind_namespace
  private_endpoint = var.private_endpoint
  region = var.region
  resource_group_name = module.resource_group.name
  sync = var.sysdig-bind_sync
}
module "vpe-cos" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-vpe-gateway?ref=v1.6.2"

  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.workload_name_prefix
  region = var.region
  resource_crn = module.cos.crn
  resource_group_name = module.resource_group.name
  resource_label = module.cos.label
  resource_service = module.cos.service
  sync = var.vpe-cos_sync
  vpc_id = module.vpe-subnets.vpc_id
  vpc_subnet_count = module.vpe-subnets.count
  vpc_subnets = module.vpe-subnets.subnets
}
module "vpe-subnets" {
  source = "cloud-native-toolkit/vpc-subnets/ibm"
  version = "1.14.0"

  _count = var.vpe-subnets__count
  acl_rules = var.vpe-subnets_acl_rules == null ? null : jsondecode(var.vpe-subnets_acl_rules)
  common_tags = var.common_tags == null ? null : jsondecode(var.common_tags)
  gateways = module.ibm-vpc-gateways.gateways
  ipv4_address_count = var.vpe-subnets_ipv4_address_count
  ipv4_cidr_blocks = var.vpe-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.vpe-subnets_ipv4_cidr_blocks)
  label = var.vpe-subnets_label
  provision = var.vpe-subnets_provision
  region = var.region
  resource_group_name = module.resource_group.name
  tags = var.vpe-subnets_tags == null ? null : jsondecode(var.vpe-subnets_tags)
  vpc_name = module.ibm-vpc.name
  zone_offset = var.vpe-subnets_zone_offset
}
module "worker-subnets" {
  source = "cloud-native-toolkit/vpc-subnets/ibm"
  version = "1.14.0"

  _count = var.workload_worker_subnet_count
  acl_rules = var.worker-subnets_acl_rules == null ? null : jsondecode(var.worker-subnets_acl_rules)
  common_tags = var.common_tags == null ? null : jsondecode(var.common_tags)
  gateways = module.ibm-vpc-gateways.gateways
  ipv4_address_count = var.worker-subnets_ipv4_address_count
  ipv4_cidr_blocks = var.worker-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.worker-subnets_ipv4_cidr_blocks)
  label = var.worker-subnets_label
  provision = var.worker-subnets_provision
  region = var.region
  resource_group_name = module.resource_group.name
  tags = var.worker-subnets_tags == null ? null : jsondecode(var.worker-subnets_tags)
  vpc_name = module.ibm-vpc.name
  zone_offset = var.worker-subnets_zone_offset
}
