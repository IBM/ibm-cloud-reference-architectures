module "login" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.0.0"

  server_url = var.server_url
  user = var.login_user
  password = var.ibmcloud_api_key
  token = var.login_token
  skip = var.login_skip

}
module "namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.1.1"

  cluster_config_file_path = module.cluster.config_file_path
  name = var.namespace_name
  create_operator_group = var.namespace_create_operator_group

}
module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.0.0"

  server_url = var.server_url
  user = var.cluster_user
  password = var.cluster_password
  token = var.cluster_token
  skip = var.cluster_skip

}
module "argocd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd?ref=v2.12.1"

  cluster_type = module.cluster.platform.type_code
  ingress_subdomain = module.cluster.platform.ingress
  cluster_config_file = module.cluster.config_file_path
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  app_namespace = module.namespace.name
  name = var.argocd_name

}
module "olm" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-olm?ref=v1.3.0"

  cluster_config_file = module.login.config_file_path
  cluster_type = module.login.platform
  cluster_version = module.login.platform

}
module "config" {
  source = "github.com/cloud-native-toolkit/template-tools-cluster-config?ref=v0.1.0"

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
