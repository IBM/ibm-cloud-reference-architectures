variable "mgmt_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "resource_group_sync" {
  type = string
  description = "Value used to order the provisioning of the resource group"
  default = ""
}
variable "resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = false
}
variable "cs_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "cs_resource_group_sync" {
  type = string
  description = "Value used to order the provisioning of the resource group"
  default = ""
}
variable "cs_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = false
}
variable "region" {
  type = string
  description = "The IBM Cloud region where the cluster will be/has been installed."
}
variable "ibmcloud_api_key" {
  type = string
  description = "The IBM Cloud api token"
}
variable "cluster_name" {
  type = string
  description = "The name of the cluster that will be created within the resource group"
  default = ""
}
variable "worker_count" {
  type = number
  description = "The number of worker nodes that should be provisioned for classic infrastructure"
  default = 3
}
variable "cluster_flavor" {
  type = string
  description = "The machine type that will be provisioned for classic infrastructure"
  default = "bx2.4x16"
}
variable "ocp_version" {
  type = string
  description = "The version of the OpenShift cluster that should be provisioned (format 4.x)"
  default = "4.6"
}
variable "cluster_exists" {
  type = bool
  description = "Flag indicating if the cluster already exists (true or false)"
  default = true
}
variable "cluster_disable_public_endpoint" {
  type = bool
  description = "Flag indicating that the public endpoint should be disabled"
  default = false
}
variable "mgmt_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
}
variable "cluster_ocp_entitlement" {
  type = string
  description = "Value that is applied to the entitlements for OCP cluster provisioning"
  default = "cloud_pak"
}
variable "cluster_vpc_name" {
  type = string
  description = "Name of the VPC instance that will be used"
  default = ""
}
variable "cluster_vpc_subnet_count" {
  type = number
  description = "Number of vpc subnets"
  default = 0
}
variable "cluster_vpc_subnets" {
  type = string
  description = "List of subnets with labels"
  default = "[]"
}
variable "cluster_cos_id" {
  type = string
  description = "The crn of the COS instance that will be used with the OCP instance"
  default = ""
}
variable "cluster_kms_enabled" {
  type = bool
  description = "Flag indicating that kms encryption should be enabled for this cluster"
  default = false
}
variable "cluster_kms_id" {
  type = string
  description = "The crn of the KMS instance that will be used to encrypt the cluster."
  default = null
}
variable "cluster_kms_key_id" {
  type = string
  description = "The id of the root key in the KMS instance that will be used to encrypt the cluster."
  default = null
}
variable "cluster_kms_private_endpoint" {
  type = bool
  description = "Flag indicating that the private endpoint should be used to connect the KMS system to the cluster."
  default = true
}
variable "cluster_login" {
  type = bool
  description = "Flag indicating that after the cluster is provisioned, the module should log into the cluster"
  default = true
}
variable "cluster_sync" {
  type = string
  description = "Value used to order dependencies"
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
variable "artifactory_service_account" {
  type = string
  description = "The service account under which the artifactory pods should run"
  default = "artifactory-artifactory"
}
variable "artifactory_chart_version" {
  type = string
  description = "The chart version that will be used for artifactory release"
  default = "9.4.5"
}
variable "artifactory_storage_class" {
  type = string
  description = "The storage class of the persistence volume claim"
  default = ""
}
variable "artifactory_persistence" {
  type = bool
  description = "Flag to indicate if PVCs should be used"
  default = true
}
variable "artifactory_gitops_dir" {
  type = string
  description = "Directory where the gitops repo content should be written"
  default = ""
}
variable "artifactory_mode" {
  type = string
  description = "The mode of operation for the module (setup)"
  default = ""
}
variable "cluster-config_gitops_dir" {
  type = string
  description = "Directory where the gitops repo content should be written"
  default = ""
}
variable "cluster-config_banner_text" {
  type = string
  description = "Text that should be shown in the banner on the cluster"
  default = "Management"
}
variable "cluster-config_banner_background_color" {
  type = string
  description = "The background color for the banner"
  default = "purple"
}
variable "cluster-config_banner_text_color" {
  type = string
  description = "The foreground color for the banner"
  default = "white"
}
variable "dashboard_tool_config_maps" {
  type = string
  description = "The list of config maps containing connectivity information for tools"
  default = "[]"
}
variable "dashboard_image_tag" {
  type = string
  description = "The image version tag to use"
  default = "v1.4.4"
}
variable "dashboard_chart_version" {
  type = string
  description = "The helm chart version that should be installed from https://ibm-garage-cloud.github.io/toolkit-charts"
  default = "1.0.0"
}
variable "dashboard_enable_sso" {
  type = bool
  description = "Flag indicating that ssl should be enabled (OpenShift only)"
  default = true
}
variable "dashboard_gitops_dir" {
  type = string
  description = "Directory where the gitops repo content should be written"
  default = ""
}
variable "dashboard_mode" {
  type = string
  description = "The mode of operation for the module (setup)"
  default = ""
}
variable "registry_namespace" {
  type = string
  description = "The namespace that will be created in the IBM Cloud image registry. If not provided the value will default to the resource group"
}
variable "gitops_dir" {
  type = string
  description = "The directory where the gitops configuration should be stored"
  default = ""
}
variable "private_endpoint" {
  type = string
  description = "Flag indicating that the registry url should be created with private endpoints"
  default = "true"
}
variable "mode" {
  type = string
  description = "The mode of operation for the module (setup)"
  default = ""
}
variable "sonarqube_hostname" {
  type = string
  description = "The hostname that will be used for the ingress/route"
  default = "sonarqube"
}
variable "sonarqube_helm_version" {
  type = string
  description = "The version of the helm chart that should be used"
  default = "6.4.1"
}
variable "sonarqube_service_account_name" {
  type = string
  description = "The name of the service account that should be used for the deployment"
  default = "sonarqube-sa"
}
variable "sonarqube_volume_capacity" {
  type = string
  description = "The volume capacity of the persistence volume claim"
  default = "2Gi"
}
variable "sonarqube_storage_class" {
  type = string
  description = "The storage class of the persistence volume claim"
  default = ""
}
variable "git_type" {
  type = string
  description = "The type of source control system (github or gitlab) currently"
}
variable "git_url" {
  type = string
  description = "The url to the git host (base git host, org, or repo url)"
}
variable "tekton_provision" {
  type = bool
  description = "Flag indicating that Tekton should be provisioned"
  default = true
}
variable "tekton-resources_support_namespace" {
  type = string
  description = "The namespace where supporting infrastructure and configuration are running (e.g. buildah-unprivileged daemon set)"
  default = ""
}
