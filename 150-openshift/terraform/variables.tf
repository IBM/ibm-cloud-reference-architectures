variable "hpcs_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "ibmcloud_api_key" {
  type = string
  description = "The IBM Cloud api token"
}
variable "hpcs_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = false
}
variable "hpcs_region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}
variable "name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
}
variable "hpcs_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "private_endpoint" {
  type = string
  description = "Flag indicating that the service should be created with private endpoints"
  default = "true"
}
variable "hpcs_plan" {
  type = string
  description = "The type of plan the service instance should run under (tiered-pricing)"
  default = "standard"
}
variable "hpcs_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "hpcs_number_of_crypto_units" {
  type = number
  description = "No of crypto units that has to be attached to the instance."
  default = 2
}
variable "hpcs_provision" {
  type = bool
  description = "Flag indicating that hpcs instance should be provisioned. If 'false' then the instance is expected to already exist."
  default = false
}
variable "hpcs_label" {
  type = string
  description = "The label that will be used to generate the name from the name_prefix."
  default = "hpcs"
}
variable "kms-key_provision" {
  type = bool
  description = "Flag indicating that the key should be provisioned. If false then an existing key will be looked up"
  default = false
}
variable "kms-key_name" {
  type = string
  description = "The name of the root key in the kms instance. Required if kms_enabled is true"
  default = ""
}
variable "kms-key_label" {
  type = string
  description = "The label used to build the name if one is not provided. If used the name will be `{name_prefix}-{label}`"
  default = "key"
}
variable "kms-key_rotation_interval" {
  type = number
  description = "The interval in months that a root key needs to be rotated."
  default = 3 validation { condition = var.rotation_interval >= 1 && var.rotation_interval <= 12 error_message = The rotation interval must be 1 to 12 months. }
}
variable "kms-key_dual_auth_delete" {
  type = bool
  description = "Flag indicating that the key requires dual authorization to be deleted."
  default = false
}
variable "region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}
variable "key-protect_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "key-protect_plan" {
  type = string
  description = "The type of plan the service instance should run under (tiered-pricing)"
  default = "standard"
}
variable "key-protect_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "key-protect_number_of_crypto_units" {
  type = number
  description = "No of crypto units that has to be attached to the instance."
  default = 2
}
variable "key-protect_provision" {
  type = bool
  description = "Flag indicating that hpcs instance should be provisioned. If 'false' then the instance is expected to already exist."
  default = false
}
variable "key-protect_label" {
  type = string
  description = "The label that will be used to generate the name from the name_prefix."
  default = "hpcs"
}
variable "resource_group_name" {
  type = string
  description = "The name of the resource group"
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
variable "cs_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
}
variable "cos_resource_location" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
  default = "global"
}
variable "cos_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "cos_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite or standard)"
  default = "standard"
}
variable "cos_provision" {
  type = bool
  description = "Flag indicating that key-protect instance should be provisioned"
  default = false
}
variable "cos_label" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = "cos"
}
variable "ibm-vpc_name" {
  type = string
  description = "The name of the vpc instance"
  default = ""
}
variable "ibm-vpc_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default = false
}
variable "ibm-vpc_address_prefix_count" {
  type = number
  description = "The number of ipv4_cidr_blocks"
  default = 0
}
variable "ibm-vpc_address_prefixes" {
  type = string
  description = "List of ipv4 cidr blocks for the address prefixes (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[]"
}
variable "workload-subnets_gateways" {
  type = string
  description = "List of gateway ids and zones"
  default = "[]"
}
variable "workload-subnets__count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 3
}
variable "workload-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "workload"
}
variable "workload-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
}
variable "workload-subnets_ipv4_cidr_blocks" {
  type = string
  description = "List of ipv4 cidr blocks for the subnets that will be created (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[]"
}
variable "workload-subnets_ipv4_address_count" {
  type = number
  description = "The size of the ipv4 cidr block that should be allocated to the subnet. If {ipv4_cidr_blocks} are provided then this value is ignored."
  default = 256
}
variable "workload-subnets_provision" {
  type = bool
  description = "Flag indicating that the subnet should be provisioned. If 'false' then the subnet will be looked up."
  default = false
}
variable "workload-subnets_acl_rules" {
  type = string
  description = "List of rules to set on the subnet access control list"
  default = "[]"
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
  default = false
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
  default = true
}
variable "cluster_kms_enabled" {
  type = bool
  description = "Flag indicating that kms encryption should be enabled for this cluster"
  default = true
}
variable "cluster_kms_private_endpoint" {
  type = bool
  description = "Flag indicating that the private endpoint should be used to connect the KMS system to the cluster."
  default = true
}
variable "cluster_login" {
  type = bool
  description = "Flag indicating that after the cluster is provisioned, the module should log into the cluster"
  default = false
}
