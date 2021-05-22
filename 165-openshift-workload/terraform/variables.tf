variable "workload_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "ibmcloud_api_key" {
  type = string
  description = "The IBM Cloud api token"
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
variable "cs_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = false
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
  default = "\"[]\""
}
variable "cluster_cos_id" {
  type = string
  description = "The crn of the COS instance that will be used with the OCP instance"
  default = ""
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
variable "workload_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
}
variable "region" {
  type = string
  description = "The IBM Cloud region where the cluster will be/has been installed."
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
variable "cluster_ocp_entitlement" {
  type = string
  description = "Value that is applied to the entitlements for OCP cluster provisioning"
  default = "cloud_pak"
}
variable "cluster_flavor" {
  type = string
  description = "The machine type that will be provisioned for classic infrastructure"
  default = "bx2.4x16"
}
variable "cluster_disable_public_endpoint" {
  type = bool
  description = "Flag indicating that the public endpoint should be disabled"
  default = false
}
variable "cluster_kms_enabled" {
  type = bool
  description = "Flag indicating that kms encryption should be enabled for this cluster"
  default = false
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
variable "argocd_name" {
  type = string
  description = "The name for the instance"
  default = "argocd"
}
variable "argocd_operator_version" {
  type = string
  description = "The starting version of the CSV"
  default = "v0.0.9"
}
variable "namespace_name" {
  type = string
  description = "The namespace that should be created"
  default = "tools"
}
variable "cluster-config_gitops_dir" {
  type = string
  description = "Directory where the gitops repo content should be written"
  default = ""
}
variable "cluster-config_banner_text" {
  type = string
  description = "Text that should be shown in the banner on the cluster"
  default = "Workload"
}
variable "cluster-config_banner_background_color" {
  type = string
  description = "The background color for the banner"
  default = "red"
}
variable "cluster-config_banner_text_color" {
  type = string
  description = "The foreground color for the banner"
  default = "white"
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
variable "ibm-logdna-bind_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "ibm-logdna-bind_sync" {
  type = string
  description = "Semaphore to synchronize activities between modules"
  default = ""
}
variable "cs_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
}
variable "logdna_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
  default = "7-day"
}
variable "logdna_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "logdna_provision" {
  type = bool
  description = "Flag indicating that logdna instance should be provisioned"
  default = false
}
variable "logdna_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "logdna_label" {
  type = string
  description = "The label used to build the resource name if not provided"
  default = "logging"
}
variable "sysdig_plan" {
  type = string
  description = "The type of plan the service instance should run under (trial or graduated-tier)"
  default = "graduated-tier"
}
variable "sysdig_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "sysdig_provision" {
  type = bool
  description = "Flag indicating that logdna instance should be provisioned"
  default = false
}
variable "sysdig_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "sysdig_label" {
  type = string
  description = "The label used to build the resource name if not provided."
  default = "monitoring"
}
variable "sysdig-bind_namespace" {
  type = string
  description = "The namespace where the agent should be deployed"
  default = "ibm-observe"
}
variable "sysdig-bind_sync" {
  type = string
  description = "Semaphore value to sync up modules"
  default = ""
}
