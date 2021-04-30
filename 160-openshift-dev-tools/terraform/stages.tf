module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.resource_group_provision

}
module "cs_resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v2.2.1"

  resource_group_name = var.cs_resource_group_name
  ibmcloud_api_key = var.ibmcloud_api_key
  provision = var.cs_resource_group_provision

}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc?ref=v1.4.1"

  resource_group_name = module.resource_group.name
  vpc_name = var.cluster_vpc_name
  vpc_subnet_count = var.cluster_vpc_subnet_count
  vpc_subnets = jsondecode(var.cluster_vpc_subnets)
  cos_id = var.cluster_cos_id
  kms_id = var.cluster_kms_id
  kms_key_id = var.cluster_kms_key_id
  name_prefix = var.name_prefix
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
module "argocd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd?ref=v2.11.0"

  cluster_type = module.cluster.platform.type_code
  ingress_subdomain = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  app_namespace = module.namespace.name
  name = var.argocd_name
  operator_version = var.argocd_operator_version

}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.2.4"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  cluster_version = module.cluster.platform.version

}
module "namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.0.2"

  cluster_config_file_path = module.cluster.config_file_path
  name = var.namespace_name

}
module "artifactory" {
  source = "github.com/cloud-native-toolkit/terraform-tools-artifactory?ref=v1.10.2"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret_name = module.cluster.platform.tls_secret
  releases_namespace = module.namespace.name
  service_account = var.artifactory_service_account
  chart_version = var.artifactory_chart_version
  storage_class = var.artifactory_storage_class
  persistence = var.artifactory_persistence
  gitops_dir = var.artifactory_gitops_dir
  mode = var.artifactory_mode

}
module "cluster-config" {
  source = "github.com/cloud-native-toolkit/template-tools-cluster-config?ref=v0.0.1"

  cluster_type_code = module.cluster.platform.type_code
  ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret = module.cluster.platform.tls_secret
  namespace = module.namespace.name
  gitops_dir = var.cluster-config_gitops_dir

}
module "dashboard" {
  source = "github.com/cloud-native-toolkit/terraform-tools-dashboard?ref=v1.10.11"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret_name = module.cluster.platform.tls_secret
  releases_namespace = module.namespace.name
  tool_config_maps = tolist(setsubtract(split(",", var.dashboard_tool_config_maps), [""]))
  image_tag = var.dashboard_image_tag
  chart_version = var.dashboard_chart_version
  enable_sso = var.dashboard_enable_sso
  gitops_dir = var.dashboard_gitops_dir
  mode = var.dashboard_mode

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
module "ibm-logdna-bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna-bind?ref=v1.0.4"

  cluster_id = module.cluster.id
  cluster_name = module.cluster.name
  cluster_config_file_path = module.cluster.platform.kubeconfig
  tools_namespace = module.namespace.name
  resource_group_name = module.resource_group.name
  region = var.region
  private_endpoint = var.private_endpoint
  ibmcloud_api_key = var.ibmcloud_api_key
  name = var.ibm-logdna-bind_name
  sync = var.ibm-logdna-bind_sync

}
module "logdna" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-logdna?ref=v3.2.1"

  resource_group_name = module.cs_resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  plan = var.logdna_plan
  tags = tolist(setsubtract(split(",", var.logdna_tags), [""]))
  provision = var.logdna_provision
  name = var.logdna_name

}
module "pactbroker" {
  source = "github.com/cloud-native-toolkit/terraform-tools-pactbroker?ref=v1.4.3"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret_name = module.cluster.platform.tls_secret
  releases_namespace = module.namespace.name

}
module "sonarqube" {
  source = "github.com/cloud-native-toolkit/terraform-tools-sonarqube?ref=v1.9.4"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret_name = module.cluster.platform.tls_secret
  releases_namespace = module.namespace.name
  mode = var.mode
  gitops_dir = var.gitops_dir
  hostname = var.sonarqube_hostname
  helm_version = var.sonarqube_helm_version
  service_account_name = var.sonarqube_service_account_name
  volume_capacity = var.sonarqube_volume_capacity
  storage_class = var.sonarqube_storage_class

}
module "git" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-source-control?ref=v1.2.5"

  cluster_type_code = module.cluster.platform.type_code
  config_file_path = module.cluster.config_file_path
  cluster_namespace = module.namespace.name
  gitops_dir = var.gitops_dir
  type = var.git_type
  url = var.git_url

}
module "sysdig" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-sysdig?ref=v3.3.0"

  resource_group_name = module.cs_resource_group.name
  region = var.region
  name_prefix = var.cs_name_prefix
  ibmcloud_api_key = var.ibmcloud_api_key
  plan = var.sysdig_plan
  tags = tolist(setsubtract(split(",", var.sysdig_tags), [""]))
  provision = var.sysdig_provision
  name = var.sysdig_name

}
module "sysdig-bind" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-sysdig-bind?ref=v1.0.4"

  resource_group_name = module.resource_group.name
  cluster_id = module.cluster.id
  cluster_name = module.cluster.name
  cluster_config_file_path = module.cluster.config_file_path
  tools_namespace = module.namespace.name
  region = var.region
  private_endpoint = var.private_endpoint
  guid = module.sysdig.guid
  access_key = module.sysdig.access_key
  ibmcloud_api_key = var.ibmcloud_api_key
  namespace = var.sysdig-bind_namespace
  sync = var.sysdig-bind_sync

}
module "tekton" {
  source = "github.com/cloud-native-toolkit/terraform-tools-tekton?ref=v2.1.3"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file_path = module.cluster.config_file_path
  tools_namespace = module.namespace.name
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  gitops_dir = var.gitops_dir
  mode = var.mode

}
