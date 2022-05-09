module "cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login?ref=v1.2.13"

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
module "openshift-cicd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-openshift-cicd?ref=v1.11.0"

  cluster_config_file = module.cluster.config_file_path
  cluster_type = module.cluster.platform.type_code
  gitops_namespace = module.openshift-gitops.name
  ingress_subdomain = module.cluster.platform.ingress
  olm_namespace = module.olm.olm_namespace
  operator_namespace = module.olm.target_namespace
  sealed_secret_cert = module.sealed-secret-cert.cert
  sealed_secret_namespace = module.sealed-secret.name
  sealed_secret_private_key = module.sealed-secret-cert.private_key
}
module "openshift-gitops" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.3"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.openshift-gitops_create_operator_group
  name = var.openshift-gitops_name
}
module "sealed-secret" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.3"

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
module "tools_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace?ref=v3.2.3"

  cluster_config_file_path = module.cluster.config_file_path
  create_operator_group = var.tools_namespace_create_operator_group
  name = var.tools_namespace_name
}
