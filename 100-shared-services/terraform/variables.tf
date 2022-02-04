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
variable "ibmcloud_api_key" {
  type = string
  description = "The IBM Cloud api key"
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
variable "vsi-encrypt-auth_source_instance" {
  type = bool
  description = "Flag indicating that the source instance id should be mapped"
  default = false
}
variable "vsi-encrypt-auth_target_instance" {
  type = bool
  description = "Flag indicating that the target instance id should be mapped"
  default = false
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
variable "cos-encrypt-auth_source_instance" {
  type = bool
  description = "Flag indicating that the source instance id should be mapped"
  default = false
}
variable "cos-encrypt-auth_target_instance" {
  type = bool
  description = "Flag indicating that the target instance id should be mapped"
  default = false
}
variable "cs_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "resource_group_sync" {
  type = string
  description = "Value used to order the provisioning of the resource group"
  default = ""
}
variable "cs_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = true
}
variable "kms_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "kms_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = true
}
variable "ibm-cert-manager_kms_id" {
  type = string
  description = "The crn of the KMS instance that will be used to encrypt the instance."
  default = null
}
variable "ibm-cert-manager_kms_key_crn" {
  type = string
  description = "The crn of the root key in the KMS"
  default = null
}
variable "ibm-cert-manager_kms_private_url" {
  type = string
  description = "The private url of the KMS instance that will be used to encrypt the instance."
  default = null
}
variable "ibm-cert-manager_kms_public_url" {
  type = string
  description = "The public url of the KMS instance that will be used to encrypt the instance."
  default = null
}
variable "region" {
  type = string
  description = "The region where the Certificate Manager will be/has been provisioned."
}
variable "cs_name_prefix" {
  type = string
  description = "The name prefix for the Certificate Manager resource. If not provided will default to resource group name."
  default = ""
}
variable "ibm-cert-manager_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default = true
}
variable "ibm-cert-manager_kms_enabled" {
  type = bool
  description = "Flag indicating that kms encryption should be enabled for this instance"
  default = false
}
variable "ibm-cert-manager_kms_private_endpoint" {
  type = bool
  description = "Flag indicating the KMS private endpoint should be used"
  default = true
}
variable "ibm-cert-manager_name" {
  type = string
  description = "Name of the Certificate Manager. If not provided will be generated as $name_prefix-$label"
  default = ""
}
variable "ibm-cert-manager_label" {
  type = string
  description = "Label used to build the Certificate Manager name if not provided."
  default = "cm"
}
variable "ibm-cert-manager_private_endpoint" {
  type = bool
  description = "Flag indicating that the service should be access using private endpoints"
  default = false
}
variable "flow-log-auth_source_service_name" {
  type = string
  description = "The name of the service that will be authorized to access the target service. This value is the name of the service as it appears in the service catalog."
  default = "is"
}
variable "flow-log-auth_source_resource_instance_id" {
  type = string
  description = "The instance id of the source service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "flow-log-auth_source_resource_type" {
  type = string
  description = "The resource type of the source service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = "flow-log-collector"
}
variable "flow-log-auth_source_resource_group_id" {
  type = string
  description = "The id of the resource group that will be used to scope which source services will be authorized to access the target service. If not provided the authorization will be scoped to the entire account. This value is superseded by the source_resource_instance_id"
  default = null
}
variable "flow-log-auth_provision" {
  type = bool
  description = "Flag indicating that the service authorization should be created"
  default = true
}
variable "flow-log-auth_roles" {
  type = string
  description = "A list of roles that should be granted on the target service (e.g. Reader, Writer)."
  default = "[\"Writer\"]"
}
variable "flow-log-auth_source_service_account" {
  type = string
  description = "GUID of the account where the source service is provisioned. This is required to authorize service access across accounts."
  default = null
}
variable "flow-log-auth_source_instance" {
  type = bool
  description = "Flag indicating that the source instance id should be mapped"
  default = false
}
variable "flow-log-auth_target_instance" {
  type = bool
  description = "Flag indicating that the target instance id should be mapped"
  default = false
}
variable "vsi-encrypt-auth1_source_service_name" {
  type = string
  description = "The name of the service that will be authorized to access the target service. This value is the name of the service as it appears in the service catalog."
  default = "server-protect"
}
variable "vsi-encrypt-auth1_source_resource_instance_id" {
  type = string
  description = "The instance id of the source service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "vsi-encrypt-auth1_source_resource_type" {
  type = string
  description = "The resource type of the source service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = null
}
variable "vsi-encrypt-auth1_roles" {
  type = string
  description = "A list of roles that should be granted on the target service (e.g. Reader, Writer)."
  default = "[\"Reader\"]"
}
variable "vsi-encrypt-auth1_source_service_account" {
  type = string
  description = "GUID of the account where the source service is provisioned. This is required to authorize service access across accounts."
  default = null
}
variable "vsi-encrypt-auth1_source_instance" {
  type = bool
  description = "Flag indicating that the source instance id should be mapped"
  default = false
}
variable "vsi-encrypt-auth1_target_instance" {
  type = bool
  description = "Flag indicating that the target instance id should be mapped"
  default = false
}
variable "kube-encrypt-auth_source_service_name" {
  type = string
  description = "The name of the service that will be authorized to access the target service. This value is the name of the service as it appears in the service catalog."
  default = "containers-kubernetes"
}
variable "kube-encrypt-auth_source_resource_instance_id" {
  type = string
  description = "The instance id of the source service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "kube-encrypt-auth_source_resource_type" {
  type = string
  description = "The resource type of the source service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = null
}
variable "kube-encrypt-auth_roles" {
  type = string
  description = "A list of roles that should be granted on the target service (e.g. Reader, Writer)."
  default = "[\"Reader\"]"
}
variable "kube-encrypt-auth_source_service_account" {
  type = string
  description = "GUID of the account where the source service is provisioned. This is required to authorize service access across accounts."
  default = null
}
variable "kube-encrypt-auth_source_instance" {
  type = bool
  description = "Flag indicating that the source instance id should be mapped"
  default = false
}
variable "kube-encrypt-auth_target_instance" {
  type = bool
  description = "Flag indicating that the target instance id should be mapped"
  default = false
}
variable "vpn-cert-manager-auth_source_service_name" {
  type = string
  description = "The name of the service that will be authorized to access the target service. This value is the name of the service as it appears in the service catalog."
  default = "is"
}
variable "vpn-cert-manager-auth_source_resource_instance_id" {
  type = string
  description = "The instance id of the source service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "vpn-cert-manager-auth_source_resource_type" {
  type = string
  description = "The resource type of the source service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = "vpn-server"
}
variable "vpn-cert-manager-auth_source_resource_group_id" {
  type = string
  description = "The id of the resource group that will be used to scope which source services will be authorized to access the target service. If not provided the authorization will be scoped to the entire account. This value is superseded by the source_resource_instance_id"
  default = null
}
variable "vpn-cert-manager-auth_provision" {
  type = bool
  description = "Flag indicating that the service authorization should be created"
  default = true
}
variable "vpn-cert-manager-auth_target_service_name" {
  type = string
  description = "The name of the service to which the source service will be authorization to access. This value is the name of the service as it appears in the service catalog."
  default = "cloudcerts"
}
variable "vpn-cert-manager-auth_target_resource_instance_id" {
  type = string
  description = "The instance id of the target service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "vpn-cert-manager-auth_target_resource_type" {
  type = string
  description = "The resource type of the target service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = null
}
variable "vpn-cert-manager-auth_target_resource_group_id" {
  type = string
  description = "The id of the resource group that will be used to scope which services the source services will be authorized to access. If not provided the authorization will be scoped to the entire account. This value is superseded by the target_resource_instance_id"
  default = null
}
variable "vpn-cert-manager-auth_roles" {
  type = string
  description = "A list of roles that should be granted on the target service (e.g. Reader, Writer)."
  default = "[\"Writer\"]"
}
variable "vpn-cert-manager-auth_source_service_account" {
  type = string
  description = "GUID of the account where the source service is provisioned. This is required to authorize service access across accounts."
  default = null
}
variable "vpn-cert-manager-auth_source_instance" {
  type = bool
  description = "Flag indicating that the source instance id should be mapped"
  default = false
}
variable "vpn-cert-manager-auth_target_instance" {
  type = bool
  description = "Flag indicating that the target instance id should be mapped"
  default = false
}
variable "kms_region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}
variable "kms_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default = ""
}
variable "kms_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "private_endpoint" {
  type = string
  description = "Flag indicating that the service should be created with private endpoints"
  default = "true"
}
variable "kms_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "kms_provision" {
  type = bool
  description = "Flag indicating that key-protect instance should be provisioned"
  default = true
}
variable "kms_number_of_crypto_units" {
  type = number
  description = "No of crypto units that has to be attached to the instance."
  default = 2
}
variable "kms_service" {
  type = string
  description = "The name of the KMS provider that should be used (keyprotect or hpcs)"
  default = "keyprotect"
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
  description = "Flag indicating that cos instance should be provisioned"
  default = true
}
variable "cos_label" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = "cos"
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
  default = true
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
  default = true
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
