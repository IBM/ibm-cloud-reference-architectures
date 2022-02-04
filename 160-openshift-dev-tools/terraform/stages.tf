module "resource_group" {
  source = "github.com/cloud-native-toolkit/terraform-ibm-resource-group?ref=v3.0.1"

  resource_group_name = var.mgmt_resource_group_name
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
  name_prefix = var.mgmt_name_prefix
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
module "artifactory" {
  source = "github.com/cloud-native-toolkit/terraform-tools-artifactory?ref=v1.12.2"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret_name = module.cluster.platform.tls_secret
  releases_namespace = module.namespace.name
  toolkit_namespace = module.console-link-job.namespace
  service_account = var.artifactory_service_account
  chart_version = var.artifactory_chart_version
  storage_class = var.artifactory_storage_class
  persistence = var.artifactory_persistence
  gitops_dir = var.artifactory_gitops_dir
  mode = var.artifactory_mode
}
module "console-link-job" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-console-link-job?ref=v1.0.2"

  cluster_config_file = module.cluster.config_file_path
  namespace = module.namespace.name
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
module "dashboard" {
  source = "github.com/cloud-native-toolkit/terraform-tools-dashboard?ref=v1.10.14"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret_name = module.cluster.platform.tls_secret
  releases_namespace = module.namespace.name
  tool_config_maps = var.dashboard_tool_config_maps == null ? null : jsondecode(var.dashboard_tool_config_maps)
  image_tag = var.dashboard_image_tag
  chart_version = var.dashboard_chart_version
  enable_sso = var.dashboard_enable_sso
  gitops_dir = var.dashboard_gitops_dir
  mode = var.dashboard_mode
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
module "pactbroker" {
  source = "github.com/cloud-native-toolkit/terraform-tools-pactbroker?ref=v1.5.5"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret_name = module.cluster.platform.tls_secret
  releases_namespace = module.namespace.name
  toolkit_namespace = module.console-link-job.namespace
}
module "sonarqube" {
  source = "github.com/cloud-native-toolkit/terraform-tools-sonarqube?ref=v1.10.2"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret_name = module.cluster.platform.tls_secret
  releases_namespace = module.namespace.name
  mode = var.mode
  gitops_dir = var.gitops_dir
  toolkit_namespace = module.console-link-job.namespace
  hostname = var.sonarqube_hostname
  helm_version = var.sonarqube_helm_version
  service_account_name = var.sonarqube_service_account_name
  volume_capacity = var.sonarqube_volume_capacity
  storage_class = var.sonarqube_storage_class
}
module "git" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-source-control?ref=v1.3.1"

  cluster_type_code = module.cluster.platform.type_code
  config_file_path = module.cluster.config_file_path
  cluster_namespace = module.namespace.name
  gitops_dir = var.gitops_dir
  type = var.git_type
  url = var.git_url
  toolkit_namespace = module.console-link-job.namespace
}
module "tekton" {
  source = "github.com/cloud-native-toolkit/terraform-tools-tekton?ref=v2.3.5"

  cluster_type = module.cluster.platform.type_code
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_config_file_path = module.cluster.config_file_path
  tools_namespace = module.namespace.name
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  gitops_dir = var.gitops_dir
  mode = var.mode
  provision = var.tekton_provision
}
module "tekton-resources" {
  source = "github.com/cloud-native-toolkit/terraform-tools-tekton-resources?ref=v2.3.0"

  cluster_type = module.cluster.platform.type_code
  cluster_config_file_path = module.cluster.config_file_path
  resource_namespace = module.namespace.name
  support_namespace = var.tekton-resources_support_namespace
}
