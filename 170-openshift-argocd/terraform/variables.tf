variable "server_url" {
  type = string
  description = "The url for the OpenShift api"
  default = ""
}
variable "login_user" {
  type = string
  description = "Username for login"
  default = "apikey"
}
variable "ibmcloud_api_key" {
  type = string
  description = "Password for login"
  default = ""
}
variable "login_token" {
  type = string
  description = "Token used for authentication"
  default = ""
}
variable "login_skip" {
  type = bool
  description = "Flag indicating that the cluster login has already been performed"
  default = false
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
variable "cluster_user" {
  type = string
  description = "Username for login"
  default = ""
}
variable "cluster_password" {
  type = string
  description = "Password for login"
  default = ""
}
variable "cluster_token" {
  type = string
  description = "Token used for authentication"
  default = ""
}
variable "cluster_skip" {
  type = bool
  description = "Flag indicating that the cluster login has already been performed"
  default = false
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
