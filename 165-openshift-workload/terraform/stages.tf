module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.workload_resource_group_name
  sync = var.resource_group_sync
  provision = var.resource_group_provision
}
module "cs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.cs_resource_group_name
  sync = var.cs_resource_group_sync
  provision = var.cs_resource_group_provision
}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc?ref=v1.10.3"

  resource_group_name = module.resource_group.name
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name = var.cluster_name
  worker_count = var.worker_count
  flavor = var.cluster_flavor
  ocp_version = var.ocp_version
  exists = var.cluster_exists
  disable_public_endpoint = var.cluster_disable_public_endpoint
  name_prefix = var.workload_name_prefix
  ocp_entitlement = var.cluster_ocp_entitlement
  vpc_name = var.cluster_vpc_name
  vpc_subnet_count = var.cluster_vpc_subnet_count
  vpc_subnets = var.cluster_vpc_subnets == null ? null : jsondecode(var.cluster_vpc_subnets)
  cos_id = var.cluster_cos_id
  kms_enabled = var.cluster_kms_enabled
  kms_id = var.cluster_kms_id
  kms_key_id = var.cluster_kms_key_id
  kms_private_endpoint = var.cluster_kms_private_endpoint
  login = var.cluster_login
  sync = var.cluster_sync
}
module "namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.1.3"

  cluster_config_file_path = module.cluster.config_file_path
  name = var.namespace_name
  create_operator_group = var.namespace_create_operator_group
}
module "argocd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd?ref=v2.17.9"

  cluster_config_file = module.cluster.config_file_path
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  app_namespace = module.namespace.name
  cluster_type = var.argocd_cluster_type
  name = var.argocd_name
}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.3.2"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  cluster_version = module.cluster.platform.version
}
module "cluster-config" {
  source = "github.com/cloud-native-toolkit/template-tools-cluster-config?ref=v0.1.2"

  cluster_type_code = module.cluster.platform.type_code
  ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret = module.cluster.platform.tls_secret
  namespace = module.namespace.name
  gitops_dir = var.cluster-config_gitops_dir
  banner_text = var.cluster-config_banner_text
  banner_background_color = var.cluster-config_banner_background_color
  banner_text_color = var.cluster-config_banner_text_color
}
module "registry" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-image-registry?ref=v2.1.2"

  config_file_path = module.cluster.config_file_path
  cluster_type_code = module.cluster.platform.type_code
  cluster_namespace = module.namespace.name
  resource_group_name = module.resource_group.name
  registry_namespace = var.registry_namespace
  region = var.region
  gitops_dir = var.gitops_dir
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
}
