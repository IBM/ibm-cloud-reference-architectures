module "hpcs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.hpcs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.hpcs_resource_group_provision

}
module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.resource_group_provision

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
  tags = tolist(setsubtract(split(",", var.hpcs_tags), [""]))
  number_of_crypto_units = var.hpcs_number_of_crypto_units
  provision = var.hpcs_provision
  label = var.hpcs_label

}
module "ibm-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.8.1"

  resource_group_id = module.resource_group.id
  resource_group_name = module.resource_group.name
  region = var.region
  name = var.ibm-vpc_name
  name_prefix = var.name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.ibm-vpc_provision

}
module "workload-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.2.1"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  acl_id = module.ibm-vpc.acl_id
  gateways = jsondecode(var.workload-subnets_gateways)
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.workload-subnets__count
  label = var.workload-subnets_label
  ipv4_cidr_blocks = tolist(setsubtract(split(",", var.workload-subnets_ipv4_cidr_blocks), [""]))
  ipv4_address_count = var.workload-subnets_ipv4_address_count
  provision = var.workload-subnets_provision

}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc?ref=v1.3.4"

  resource_group_name = module.resource_group.name
  vpc_name = module.ibm-vpc.name
  vpc_subnet_count = module.workload-subnets.count
  vpc_subnets = module.workload-subnets.subnets
  cos_id = module.cos.id
  kms_id = module.hpcs.guid
  kms_key_id = var.cluster_kms_key_id
  name_prefix = var.name_prefix
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name = var.cluster_name
  worker_count = var.worker_count
  ocp_version = var.ocp_version
  exists = var.cluster_exists
  gitops_dir = var.gitops_dir
  flavor = var.cluster_flavor
  disable_public_endpoint = var.cluster_disable_public_endpoint
  kms_enabled = var.cluster_kms_enabled
  kms_private_endpoint = var.cluster_kms_private_endpoint
  authorize_kms = var.cluster_authorize_kms

}
module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage?ref=v3.2.0"

  resource_group_name = module.hpcs_resource_group.name
  name_prefix = var.name_prefix
  resource_location = var.cos_resource_location
  tags = tolist(setsubtract(split(",", var.cos_tags), [""]))
  plan = var.cos_plan
  provision = var.cos_provision
  label = var.cos_label

}
