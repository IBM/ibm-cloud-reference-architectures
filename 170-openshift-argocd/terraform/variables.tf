variable "server_url" {
  type = string
  description = "The url for the OpenShift api"
}
variable "cluster_login_user" {
  type = string
  description = "Username for login"
  default = "apikey"
}
variable "ibmcloud_api_key" {
  type = string
  description = "Password for login"
  default = ""
}
variable "cluster_login_token" {
  type = string
  description = "Token used for authentication"
}
variable "cluster_skip" {
  type = bool
  description = "Flag indicating that the cluster login has already been performed"
  default = false
}
variable "cluster_cluster_version" {
  type = string
  description = "The version of the cluster (passed through to the output)"
  default = ""
}
variable "cluster_ingress_subdomain" {
  type = string
  description = "The ingress subdomain of the cluster (passed through to the output)"
  default = ""
}
variable "cluster_tls_secret_name" {
  type = string
  description = "The name of the secret containing the tls certificates for the ingress subdomain (passed through to the output)"
  default = ""
}
variable "namespace_name" {
  type = string
  description = "The namespace that should be created"
  default = "tools"
}
variable "namespace_create_operator_group" {
  type = bool
  description = "Flag indicating that an operator group should be created in the namespace"
  default = true
}
variable "argocd_cluster_type" {
  type = string
  description = "The type of cluster (openshift or kubernetes)"
  default = "ocp4"
}
variable "argocd_name" {
  type = string
  description = "The name for the instance"
  default = "argocd-cluster"
}
variable "config_gitops_dir" {
  type = string
  description = "Directory where the gitops repo content should be written"
  default = ""
}
variable "config_banner_text" {
  type = string
  description = "Text that should be shown in the banner on the cluster"
  default = "Workload"
}
variable "config_banner_background_color" {
  type = string
  description = "The background color for the banner"
  default = "red"
}
variable "config_banner_text_color" {
  type = string
  description = "The foreground color for the banner"
  default = "white"
}
