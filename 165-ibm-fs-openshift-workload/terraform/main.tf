module "cluster" {
  source = "cloud-native-toolkit/ocp-vpc/ibm"
  version = "1.13.3"

  cos_id = var.cluster_cos_id
  disable_public_endpoint = var.cluster_disable_public_endpoint
  exists = var.cluster_exists
  flavor = var.cluster_flavor
  force_delete_storage = var.cluster_force_delete_storage
  ibmcloud_api_key = var.ibmcloud_api_key
  kms_enabled = var.cluster_kms_enabled
  kms_id = var.cluster_kms_id
  kms_key_id = var.cluster_kms_key_id
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
  vpc_name = var.cluster_vpc_name
  vpc_subnet_count = var.cluster_vpc_subnet_count
  vpc_subnets = var.cluster_vpc_subnets == null ? null : jsondecode(var.cluster_vpc_subnets)
  worker_count = var.worker_count
}
module "cluster-config" {
  source = "github.com/cloud-native-toolkit/template-tools-cluster-config?ref=v0.1.2"

  banner_background_color = var.cluster-config_banner_background_color
  banner_text = var.cluster-config_banner_text
  banner_text_color = var.cluster-config_banner_text_color
  cluster_config_file = module.cluster.config_file_path
  cluster_type_code = module.cluster.platform.type_code
  gitops_dir = var.cluster-config_gitops_dir
  ingress_hostname = module.cluster.platform.ingress
  namespace = module.tools_namespace.name
  tls_secret = module.cluster.platform.tls_secret
}
module "cs_resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.2.15"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = var.cs_resource_group_name
  sync = var.cs_resource_group_sync
}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.3.2"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  cluster_version = module.cluster.platform.version
}
module "openshift-cicd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-openshift-cicd?ref=v1.7.20"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  gitops_namespace = module.openshift-gitops.name
  ingress_subdomain = module.cluster.platform.ingress
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  sealed_secret_cert = module.sealed-secret-cert.cert
  sealed_secret_namespace = module.sealed-secret.name
  sealed_secret_private_key = module.sealed-secret-cert.private_key
  tools_namespace = module.tools.name
}
module "openshift-gitops" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.2"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.openshift-gitops_create_operator_group
  name = var.openshift-gitops_name
}
module "registry" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-image-registry?ref=v2.1.2"

  cluster_namespace = module.tools_namespace.name
  cluster_type_code = module.cluster.platform.type_code
  config_file_path = module.cluster.config_file_path
  gitops_dir = var.gitops_dir
  ibmcloud_api_key = var.ibmcloud_api_key
  private_endpoint = var.private_endpoint
  region = var.region
  registry_namespace = var.registry_namespace
  resource_group_name = module.resource_group.name
}
module "resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.2.15"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = var.workload_resource_group_name
  sync = var.resource_group_sync
}
module "sealed-secret" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.2"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.sealed-secret_create_operator_group
  name = var.sealed-secret_name
}
module "sealed-secret-cert" {
  source = "github.com/cloud-native-toolkit/terraform-util-sealed-secret-cert?ref=v1.0.1"

  cert = var.sealed-secret-cert_cert
  cert_file = var.sealed-secret-cert_cert_file
  private_key = var.sealed-secret-cert_private_key
  private_key_file = var.sealed-secret-cert_private_key_file
}
module "tools" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.2"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.tools_create_operator_group
  name = var.tools_name
}
module "tools_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.2"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.tools_namespace_create_operator_group
  name = var.tools_namespace_name
}
