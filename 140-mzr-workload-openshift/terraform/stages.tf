module "mgmt_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.mgmt_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.mgmt_resource_group_provision

}
module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.workload_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.workload_resource_group_provision

}
module "hpcs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.hpcs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.hpcs_resource_group_provision

}
module "cs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.cs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.cs_resource_group_provision

}
module "hpcs" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-hpcs?ref=v1.2.1"

  resource_group_name = module.hpcs_resource_group.name
  region = var.hpcs_region
  name_prefix = var.workload_name_prefix
  name = var.hpcs_name
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
  plan = var.hpcs_plan
  tags = tolist(setsubtract(split(",", var.hpcs_tags), [""]))
  number_of_crypto_units = var.hpcs_number_of_crypto_units
  provision = var.hpcs_provision
  label = var.hpcs_label

}
module "management-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.8.1"

  resource_group_id = module.mgmt_resource_group.id
  resource_group_name = module.mgmt_resource_group.name
  region = var.region
  name = var.management-vpc_name
  name_prefix = var.mgmt_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.management-vpc_provision

}
module "ibm-vpc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc?ref=v1.8.1"

  resource_group_id = module.resource_group.id
  resource_group_name = module.resource_group.name
  region = var.region
  name = var.ibm-vpc_name
  name_prefix = var.workload_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.ibm-vpc_provision

}
module "ibm-vpc-gateways" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-gateways?ref=v1.2.2"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key

}
module "workload_ssh_vpn" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh?ref=v1.5.1"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name_prefix = var.workload_name_prefix
  name = var.workload_ssh_vpn_name
  label = var.workload_ssh_vpn_label
  public_key = var.workload_ssh_vpn_public_key
  private_key = var.workload_ssh_vpn_private_key
  public_key_file = var.workload_ssh_vpn_public_key_file
  private_key_file = var.workload_ssh_vpn_private_key_file
  rsa_bits = var.workload_ssh_vpn_rsa_bits

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
module "workload-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.2.3"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  acl_id = module.ibm-vpc.acl_id
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.workload-subnets__count
  label = var.workload-subnets_label
  ipv4_cidr_blocks = tolist(setsubtract(split(",", var.workload-subnets_ipv4_cidr_blocks), [""]))
  ipv4_address_count = var.workload-subnets_ipv4_address_count
  provision = var.workload-subnets_provision

}
module "vpe-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.2.3"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  acl_id = module.ibm-vpc.acl_id
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.vpe-subnets__count
  label = var.vpe-subnets_label
  ipv4_cidr_blocks = tolist(setsubtract(split(",", var.vpe-subnets_ipv4_cidr_blocks), [""]))
  ipv4_address_count = var.vpe-subnets_ipv4_address_count
  provision = var.vpe-subnets_provision

}
module "vpn-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.2.3"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  acl_id = module.ibm-vpc.acl_id
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.vpn-subnets__count
  label = var.vpn-subnets_label
  ipv4_cidr_blocks = tolist(setsubtract(split(",", var.vpn-subnets_ipv4_cidr_blocks), [""]))
  ipv4_address_count = var.vpn-subnets_ipv4_address_count
  provision = var.vpn-subnets_provision

}
module "bastion-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.2.3"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  acl_id = module.ibm-vpc.acl_id
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.bastion-subnets__count
  label = var.bastion-subnets_label
  ipv4_cidr_blocks = tolist(setsubtract(split(",", var.bastion-subnets_ipv4_cidr_blocks), [""]))
  ipv4_address_count = var.bastion-subnets_ipv4_address_count
  provision = var.bastion-subnets_provision

}
module "scc-subnets" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets?ref=v1.2.3"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  acl_id = module.ibm-vpc.acl_id
  gateways = module.ibm-vpc-gateways.gateways
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  _count = var.scc-subnets__count
  label = var.scc-subnets_label
  ipv4_cidr_blocks = tolist(setsubtract(split(",", var.scc-subnets_ipv4_cidr_blocks), [""]))
  ipv4_address_count = var.scc-subnets_ipv4_address_count
  provision = var.scc-subnets_provision

}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc?ref=v1.4.1"

  resource_group_name = module.resource_group.name
  vpc_name = module.ibm-vpc.name
  vpc_subnet_count = module.workload-subnets.count
  vpc_subnets = module.workload-subnets.subnets
  cos_id = module.cos.id
  kms_id = module.hpcs.guid
  kms_key_id = var.kms_key_id
  name_prefix = var.workload_name_prefix
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name = var.cluster_name
  worker_count = var.worker_count
  ocp_version = var.ocp_version
  exists = var.cluster_exists
  flavor = var.cluster_flavor
  disable_public_endpoint = var.cluster_disable_public_endpoint
  kms_enabled = var.cluster_kms_enabled
  kms_private_endpoint = var.cluster_kms_private_endpoint
  authorize_kms = var.cluster_authorize_kms
  login = var.cluster_login

}
module "cos" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-object-storage?ref=v3.2.0"

  resource_group_name = module.mgmt_resource_group.name
  name_prefix = var.workload_name_prefix
  resource_location = var.cos_resource_location
  tags = tolist(setsubtract(split(",", var.cos_tags), [""]))
  plan = var.cos_plan
  provision = var.cos_provision
  label = var.cos_label

}
module "scc" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-scc-collector?ref=v1.1.0"

  resource_group_id = module.resource_group.id
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  vpc_name = module.ibm-vpc.name
  vpc_subnet_count = module.scc-subnets.count
  vpc_subnets = module.scc-subnets.subnets
  ssh_key_id = module.workload_ssh_scc.id
  ssh_private_key = module.workload_ssh_scc.private_key
  scc_registration_key = var.workload_scc_registration_key

}
module "vsi-bastion" {
  source = "github.com/cloud-native-toolkit/terraform-vsi-bastion?ref=v1.2.0"

  vpc_name = module.ibm-vpc.name
  subnet_count = module.bastion-subnets.count
  subnets = module.bastion-subnets.subnets
  resource_group_name = module.resource_group.name
  ssh_key_id = module.workload_ssh_bastion.id
  region = var.region
  name_prefix = var.workload_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  tags = tolist(setsubtract(split(",", var.vsi-bastion_tags), [""]))
  create_public_ip = var.vsi-bastion_create_public_ip

}
module "vsi-vpn" {
  source = "github.com/cloud-native-toolkit/terraform-vsi-vpn?ref=v1.0.7"

  resource_group_id = module.resource_group.id
  vpc_name = module.ibm-vpc.name
  subnet_count = module.vpn-subnets.count
  subnets = module.vpn-subnets.subnets
  ssh_key_id = module.workload_ssh_vpn.id
  ssh_private_key = module.workload_ssh_vpn.private_key
  instance_count = module.vsi-bastion.instance_count
  instance_network_ids = module.vsi-bastion.network_interface_ids
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  tags = tolist(setsubtract(split(",", var.vsi-vpn_tags), [""]))
  image_name = "ibm-centos-7-9-minimal-amd64-3"

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
