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
