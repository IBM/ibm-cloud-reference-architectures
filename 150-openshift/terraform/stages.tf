module "hpcs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.hpcs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.hpcs_resource_group_provision

}
module "hpcs" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-hpcs?ref=v1.2.1"

  resource_group_name = module.hpcs_resource_group.name
  region = var.hpcs_region
  name_prefix = var.name_prefix
  name = var.hpcs_name
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
  plan = var.hpcs_plan
  tags = var.hpcs_tags == null ? null : jsondecode(var.hpcs_tags)
  number_of_crypto_units = var.hpcs_number_of_crypto_units
  provision = var.hpcs_provision
  label = var.hpcs_label

}
module "kms-key" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-kms-key?ref=v1.1.0"

  kms_id = module.key-protect.guid
  region = module.key-protect.location
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.name_prefix
  provision = var.kms-key_provision
  name = var.kms-key_name
  label = var.kms-key_label

}
module "key-protect" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-hpcs?ref=v1.2.1"

  resource_group_name = module.hpcs_resource_group.name
  region = var.region
  name_prefix = var.name_prefix
  name = var.key-protect_name
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
  plan = var.key-protect_plan
  tags = var.key-protect_tags == null ? null : jsondecode(var.key-protect_tags)
  number_of_crypto_units = var.key-protect_number_of_crypto_units
  provision = var.key-protect_provision
  label = var.key-protect_label

}
module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.resource_group_provision

}
module "cs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.cs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.cs_resource_group_provision

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
module "ibm-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.10.0"

  resource_group_id = module.resource_group.id
  resource_group_name = module.resource_group.name
  region = var.region
  name = var.ibm-vpc_name
  name_prefix = var.name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.ibm-vpc_provision
  address_prefix_count = var.ibm-vpc_address_prefix_count
  address_prefixes = var.ibm-vpc_address_prefixes == null ? null : jsondecode(var.ibm-vpc_address_prefixes)

}
module "workload-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.6.0"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  gateways = var.workload-subnets_gateways == null ? null : jsondecode(var.workload-subnets_gateways)
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.workload-subnets__count
  label = var.workload-subnets_label
  zone_offset = var.workload-subnets_zone_offset
  ipv4_cidr_blocks = var.workload-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.workload-subnets_ipv4_cidr_blocks)
  ipv4_address_count = var.workload-subnets_ipv4_address_count
  provision = var.workload-subnets_provision
  acl_rules = var.workload-subnets_acl_rules == null ? null : jsondecode(var.workload-subnets_acl_rules)

}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc?ref=v1.5.0"

  resource_group_name = module.resource_group.name
  vpc_name = module.ibm-vpc.name
  vpc_subnet_count = module.workload-subnets.count
  vpc_subnets = module.workload-subnets.subnets
  cos_id = module.cos.id
  kms_id = module.kms-key.kms_id
  kms_key_id = module.kms-key.id
  name_prefix = var.name_prefix
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name = var.cluster_name
  worker_count = var.worker_count
  ocp_version = var.ocp_version
  exists = var.cluster_exists
  ocp_entitlement = var.cluster_ocp_entitlement
  flavor = var.cluster_flavor
  disable_public_endpoint = var.cluster_disable_public_endpoint
  kms_enabled = var.cluster_kms_enabled
  kms_private_endpoint = var.cluster_kms_private_endpoint
  login = var.cluster_login

}
