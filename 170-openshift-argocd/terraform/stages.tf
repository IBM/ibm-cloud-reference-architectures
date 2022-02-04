module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.2.4"

  server_url = var.server_url
  login_user = var.cluster_login_user
  login_password = var.ibmcloud_api_key
  login_token = var.cluster_login_token
  skip = var.cluster_skip
  cluster_version = var.cluster_cluster_version
  ingress_subdomain = var.cluster_ingress_subdomain
  tls_secret_name = var.cluster_tls_secret_name
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
module "config" {
  source = "github.com/cloud-native-toolkit/template-tools-cluster-config?ref=v0.1.2"

  cluster_type_code = module.cluster.platform.type_code
  ingress_hostname = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  tls_secret = module.cluster.platform.tls_secret
  namespace = module.namespace.name
  gitops_dir = var.config_gitops_dir
  banner_text = var.config_banner_text
  banner_background_color = var.config_banner_background_color
  banner_text_color = var.config_banner_text_color
}
