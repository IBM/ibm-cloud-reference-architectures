variable "cs_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "ibmcloud_api_key" {
  type = string
  description = "The IBM Cloud api token"
}
variable "cs_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = true
}
variable "hpcs_resource_group_name" {
  type = string
  description = "The name of the resource group"
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
  default = ""
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
variable "region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}
variable "cs_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default = ""
}
variable "ibm-activity-tracker_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = ""
}
variable "ibm-activity-tracker_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
  default = "7-day"
}
variable "ibm-activity-tracker_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned"
  default = false
}
variable "cos_resource_location" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
  default = "global"
}
variable "cos_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = ""
}
variable "cos_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite or standard)"
  default = "standard"
}
variable "cos_provision" {
  type = bool
  description = "Flag indicating that key-protect instance should be provisioned"
  default = true
}
variable "cos_label" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = "cos"
}
variable "key-protect_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = ""
}
variable "key-protect_plan" {
  type = string
  description = "The type of plan the service instance should run under (tiered-pricing)"
  default = "tiered-pricing"
}
variable "key-protect_provision" {
  type = bool
  description = "Flag indicating that key-protect instance should be provisioned"
  default = true
}
variable "key-protect_label" {
  type = string
  description = "The label used as generate the name of the resource using the name_prefix"
  default = "keyprotect"
}
variable "logdna_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
  default = "7-day"
}
variable "logdna_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = ""
}
variable "logdna_provision" {
  type = bool
  description = "Flag indicating that logdna instance should be provisioned"
  default = true
}
variable "logdna_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "sysdig_plan" {
  type = string
  description = "The type of plan the service instance should run under (trial or graduated-tier)"
  default = "graduated-tier"
}
variable "sysdig_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = ""
}
variable "sysdig_provision" {
  type = bool
  description = "Flag indicating that logdna instance should be provisioned"
  default = true
}
variable "sysdig_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
