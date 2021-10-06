module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.workload_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.resource_group_provision

}
module "cs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.3.0"

  resource_group_name = var.cs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.cs_resource_group_provision

}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc?ref=v1.9.0"

  resource_group_name = module.resource_group.name
  vpc_name = var.cluster_vpc_name
  vpc_subnet_count = var.cluster_vpc_subnet_count
  vpc_subnets = var.cluster_vpc_subnets == null ? null : jsondecode(var.cluster_vpc_subnets)
  cos_id = var.cluster_cos_id
  kms_id = var.cluster_kms_id
  kms_key_id = var.cluster_kms_key_id
  name_prefix = var.workload_name_prefix
  region = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  name = var.cluster_name
  worker_count = var.worker_count
  ocp_version = var.ocp_version
  exists = var.cluster_exists
  sync = var.cluster_sync
  flavor = var.cluster_flavor
  disable_public_endpoint = var.cluster_disable_public_endpoint
  ocp_entitlement = var.cluster_ocp_entitlement
  kms_enabled = var.cluster_kms_enabled
  kms_private_endpoint = var.cluster_kms_private_endpoint
  login = var.cluster_login

}
module "logdna" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna?ref=v3.3.1"

  resource_group_name = module.cs_resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  plan = var.logdna_plan
  tags = var.logdna_tags == null ? null : jsondecode(var.logdna_tags)
  provision = var.logdna_provision
  name = var.logdna_name
  label = var.logdna_label

}
module "namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.1.2"

  cluster_config_file_path = module.cluster.config_file_path
  name = var.namespace_name
  create_operator_group = var.namespace_create_operator_group

}
module "argocd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd?ref=v2.16.2"

  cluster_type = module.cluster.platform.type_code
  ingress_subdomain = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  app_namespace = module.namespace.name
  name = var.argocd_name

}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.3.1"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  cluster_version = module.cluster.platform.version

}
module "cluster-config" {
  source = "github.com/cloud-native-toolkit/template-tools-cluster-config?ref=v0.1.0"

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
  source = "github.com/cloud-native-toolkit/terraform-ibm-image-registry?ref=v2.0.3"

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
module "sysdig-bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-sysdig-bind?ref=v1.1.1"

  resource_group_name = module.resource_group.name
  cluster_id = module.cluster.id
  cluster_name = module.cluster.name
  cluster_config_file_path = module.cluster.platform.kubeconfig
  tools_namespace = module.namespace.name
  region = var.region
  private_endpoint = var.private_endpoint
  guid = module.sysdig.guid
  access_key = module.sysdig.access_key
  ibmcloud_api_key = var.ibmcloud_api_key
  namespace = var.sysdig-bind_namespace
  sync = var.sysdig-bind_sync

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
module "ibm-logdna-bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna-bind?ref=v1.1.1"

  cluster_id = module.cluster.id
  cluster_name = module.cluster.name
  cluster_config_file_path = module.cluster.platform.kubeconfig
  tools_namespace = module.namespace.name
  resource_group_name = module.resource_group.name
  sync = module.sysdig-bind.sync
  logdna_id = module.logdna.guid
  region = var.region
  private_endpoint = var.private_endpoint
  ibmcloud_api_key = var.ibmcloud_api_key

}
