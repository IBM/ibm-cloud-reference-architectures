module "argocd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd?ref=v2.18.7"

  app_namespace = module.openshift-gitops.name
  cluster_config_file = module.cluster.config_file_path
  cluster_type = var.argocd_cluster_type
  name = var.argocd_name
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.operator_namespace
}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.2.8"

  cluster_version = var.cluster_cluster_version
  ingress_subdomain = var.cluster_ingress_subdomain
  login_password = var.ibmcloud_api_key
  login_token = var.cluster_login_token
  login_user = var.cluster_login_user
  server_url = var.server_url
  skip = var.cluster_skip
  tls_secret_name = var.cluster_tls_secret_name
}
module "config" {
  source = "github.com/cloud-native-toolkit/template-tools-cluster-config?ref=v0.1.2"

  banner_background_color = var.config_banner_background_color
  banner_text = var.config_banner_text
  banner_text_color = var.config_banner_text_color
  cluster_config_file = module.cluster.config_file_path
  cluster_type_code = module.cluster.platform.type_code
  gitops_dir = var.config_gitops_dir
  ingress_hostname = module.cluster.platform.ingress
  namespace = module.tools_namespace.name
  tls_secret = module.cluster.platform.tls_secret
}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.3.2"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  cluster_version = module.cluster.platform.version
}
module "openshift-gitops" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.0"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.openshift-gitops_create_operator_group
  name = var.openshift-gitops_name
}
module "tools_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.0"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.tools_namespace_create_operator_group
  name = var.tools_namespace_name
}
