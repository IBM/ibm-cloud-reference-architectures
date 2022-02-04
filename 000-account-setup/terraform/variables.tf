variable "at_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "resource_group_sync" {
  type = string
  description = "Value used to order the provisioning of the resource group"
  default = ""
}
variable "at_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = false
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
variable "ibmcloud_api_key" {
  type = string
  description = "The api key for IBM Cloud access"
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
