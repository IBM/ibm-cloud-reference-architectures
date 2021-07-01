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
variable "hpcs_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default = ""
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
variable "at-us-east_region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
  default = "us-east"
}
variable "at-us-east_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "at-us-east_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
  default = "7-day"
}
variable "at-us-east_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned"
  default = true
}
variable "at-us-south_region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
  default = "us-south"
}
variable "at-us-south_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "at-us-south_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
  default = "7-day"
}
variable "at-us-south_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned"
  default = true
}
variable "at-eu-de_region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
  default = "eu-de"
}
variable "at-eu-de_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "at-eu-de_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
  default = "7-day"
}
variable "at-eu-de_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned"
  default = true
}
variable "at-eu-gb_region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
  default = "eu-gb"
}
variable "at-eu-gb_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "at-eu-gb_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
  default = "7-day"
}
variable "at-eu-gb_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned"
  default = true
}
variable "vsi-encrypt-auth_source_service_name" {
  type = string
  description = "The name of the service that will be authorized to access the target service. This value is the name of the service as it appears in the service catalog."
  default = "server-protect"
}
variable "vsi-encrypt-auth_source_resource_instance_id" {
  type = string
  description = "The instance id of the source service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "vsi-encrypt-auth_source_resource_type" {
  type = string
  description = "The resource type of the source service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = null
}
variable "vsi-encrypt-auth_source_resource_group_id" {
  type = string
  description = "The id of the resource group that will be used to scope which source services will be authorized to access the target service. If not provided the authorization will be scoped to the entire account. This value is superseded by the source_resource_instance_id"
  default = null
}
variable "vsi-encrypt-auth_provision" {
  type = bool
  description = "Flag indicating that the service authorization should be created"
  default = true
}
variable "vsi-encrypt-auth_target_service_name" {
  type = string
  description = "The name of the service to which the source service will be authorization to access. This value is the name of the service as it appears in the service catalog."
  default = "hs-crypto"
}
variable "vsi-encrypt-auth_target_resource_instance_id" {
  type = string
  description = "The instance id of the target service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "vsi-encrypt-auth_target_resource_type" {
  type = string
  description = "The resource type of the target service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = null
}
variable "vsi-encrypt-auth_roles" {
  type = string
  description = "A list of roles that should be granted on the target service (e.g. Reader, Writer)."
  default = "[\"Reader\"]"
}
variable "vsi-encrypt-auth_source_service_account" {
  type = string
  description = "GUID of the account where the source service is provisioned. This is required to authorize service access across accounts."
  default = null
}
variable "cos-encrypt-auth_source_service_name" {
  type = string
  description = "The name of the service that will be authorized to access the target service. This value is the name of the service as it appears in the service catalog."
  default = "cloud-object-storage"
}
variable "cos-encrypt-auth_source_resource_instance_id" {
  type = string
  description = "The instance id of the source service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "cos-encrypt-auth_source_resource_type" {
  type = string
  description = "The resource type of the source service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = null
}
variable "cos-encrypt-auth_source_resource_group_id" {
  type = string
  description = "The id of the resource group that will be used to scope which source services will be authorized to access the target service. If not provided the authorization will be scoped to the entire account. This value is superseded by the source_resource_instance_id"
  default = null
}
variable "cos-encrypt-auth_provision" {
  type = bool
  description = "Flag indicating that the service authorization should be created"
  default = true
}
variable "cos-encrypt-auth_target_service_name" {
  type = string
  description = "The name of the service to which the source service will be authorization to access. This value is the name of the service as it appears in the service catalog."
  default = "hs-crypto"
}
variable "cos-encrypt-auth_target_resource_instance_id" {
  type = string
  description = "The instance id of the target service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "cos-encrypt-auth_target_resource_type" {
  type = string
  description = "The resource type of the target service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = null
}
variable "cos-encrypt-auth_roles" {
  type = string
  description = "A list of roles that should be granted on the target service (e.g. Reader, Writer)."
  default = "[\"Reader\"]"
}
variable "cos-encrypt-auth_source_service_account" {
  type = string
  description = "GUID of the account where the source service is provisioned. This is required to authorize service access across accounts."
  default = null
}
variable "region" {
  type = string
  description = "The IBM Cloud region."
}
variable "ibm-onboard-fs-account_action" {
  type = string
  description = "USAGE: ibmcloud cr platform-metrics enable | disable"
  default = "enable"
}
variable "ibm-onboard-fs-account_mfa" {
  type = string
  description = "Defines the MFA trait for an account. Valid values are NONE No MFA trait set. TOTP For all non-federated IBM ID users TOTP4ALL For all users. LEVEL1 The Email based MFA for all users. LEVEL2 TOTP based MFA for all users. LEVEL3 U2F MFA for all users."
  default = "TOTP4ALL"
}
variable "ibm-onboard-fs-account_restrict_create_service_id" {
  type = string
  description = "Defines whether creating a service ID is access controlled. Valid values are RESTRICTED to apply access control. NOT_RESTRICTED to remove access control. NOT_SET to unset a previous set value."
  default = "RESTRICTED"
}
variable "ibm-onboard-fs-account_restrict_create_platform_apikey" {
  type = string
  description = "Defines whether creating a API Key is access controlled. Valid values are RESTRICTED to apply access control. NOT_RESTRICTED to remove access control. NOT_SET to unset a previous set value."
  default = "RESTRICTED"
}
