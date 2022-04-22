variable "ibmcloud_api_key" {
  type = string
  description = "The IBM Cloud api key"
}
variable "kms_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "kms_resource_group_sync" {
  type = string
  description = "Value used to order the provisioning of the resource group"
  default = ""
}
variable "region" {
  type = string
  description = "the value of region"
}
variable "at_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "at_resource_group_sync" {
  type = string
  description = "Value used to order the provisioning of the resource group"
  default = ""
}
variable "workload_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "resource_group_sync" {
  type = string
  description = "Value used to order the provisioning of the resource group"
  default = ""
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
variable "ibm-activity-tracker_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "ibm-activity-tracker_plan" {
  type = string
  description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
  default = "7-day"
}
variable "ibm-activity-tracker_sync" {
  type = string
  description = "Value used to order the provisioning of the instance"
  default = ""
}
variable "cs_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
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
variable "private_endpoint" {
  type = string
  description = "Flag indicating that the agent should be created with private endpoints"
  default = "true"
}
variable "ibm-flow-logs_auth_id" {
  type = string
  description = "The id of the service authorization that allows the flow log to write to the cos bucket"
  default = ""
}
variable "ibm-flow-logs_provision" {
  type = bool
  description = "Flag indicating that the subnet should be provisioned. If 'false' then the subnet will be looked up."
  default = true
}
variable "flow-log-auth_source_service_name" {
  type = string
  description = "The name of the service that will be authorized to access the target service. This value is the name of the service as it appears in the service catalog."
  default = "is"
}
variable "flow-log-auth_roles" {
  type = string
  description = "A list of roles that should be granted on the target service (e.g. Reader, Writer)."
  default = "[\"Writer\"]"
}
variable "flow-log-auth_source_resource_instance_id" {
  type = string
  description = "The instance id of the source service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "flow-log-auth_source_resource_group_id" {
  type = string
  description = "The id of the resource group that will be used to scope which source services will be authorized to access the target service. If not provided the authorization will be scoped to the entire account. This value is superseded by the source_resource_instance_id"
  default = null
}
variable "flow-log-auth_source_resource_type" {
  type = string
  description = "The resource type of the source service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
  default = "flow-log-collector"
}
variable "flow-log-auth_source_service_account" {
  type = string
  description = "GUID of the account where the source service is provisioned. This is required to authorize service access across accounts."
  default = null
}
variable "flow-log-auth_provision" {
  type = bool
  description = "Flag indicating that the service authorization should be created"
  default = true
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
variable "kms_region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}
variable "kms_tags" {
  type = string
  description = "Tags that should be applied to the service"
  default = "[]"
}
variable "kms_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default = ""
}
variable "kms_provision" {
  type = bool
  description = "Flag indicating that key-protect instance should be provisioned"
  default = false
}
variable "kms_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
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
variable "kms-key_provision" {
  type = bool
  description = "Flag indicating that the key should be provisioned. If false then an existing key will be looked up"
  default = true
}
variable "kms-key_name" {
  type = string
  description = "The name of the root key in the kms instance. Required if kms_enabled is true"
  default = ""
}
variable "workload_name_prefix" {
  type = string
  description = "The name_prefix used to build the name if one is not provided. If used the name will be `{name_prefix}-{label}`"
}
variable "kms-key_label" {
  type = string
  description = "The label used to build the name if one is not provided. If used the name will be `{name_prefix}-{label}`"
  default = "key"
}
variable "kms-key_rotation_interval" {
  type = number
  description = "The interval in months that a root key needs to be rotated."
  default = 3
}
variable "kms-key_dual_auth_delete" {
  type = bool
  description = "Flag indicating that the key requires dual authorization to be deleted."
  default = false
}
variable "kms-key_force_delete" {
  type = bool
  description = "Flag indicating that 'force' should be applied to key on delete"
  default = true
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
  default = false
}
variable "cos_label" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = "cos"
}
variable "flow_log_bucket_metrics_monitoring_crn" {
  type = string
  description = "The crn of the Metrics Monitoring instance"
  default = null
}
variable "suffix" {
  type = string
  description = "Value added to the generated name to ensure it is unique"
  default = ""
}
variable "flow_log_bucket_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default = true
}
variable "flow_log_bucket_name" {
  type = string
  description = "Name of the bucket"
  default = ""
}
variable "flow_log_bucket_label" {
  type = string
  description = "Label used to build the bucket name of not provided."
  default = "flow-logs"
}
variable "flow_log_bucket_cross_region_location" {
  type = string
  description = "The cross-region location of the bucket. This value is optional. Valid values are (us, eu, and ap). This value takes precedence over others if provided."
  default = ""
}
variable "flow_log_bucket_storage_class" {
  type = string
  description = "Storage class of the bucket. Supported values are standard, vault, cold, flex, smart."
  default = "standard"
}
variable "flow_log_bucket_allowed_ip" {
  type = string
  description = "A list of IPv4 or IPv6 addresses in CIDR notation that you want to allow access to your IBM Cloud Object Storage bucket."
  default = "[\"0.0.0.0/0\"]"
}
variable "flow_log_bucket_enable_object_versioning" {
  type = bool
  description = "Object Versioning allows the COS user to keep multiple versions of an object in a bucket to protect against accidental deletion or overwrites. (Default = false)"
  default = false
}
variable "cluster_name" {
  type = string
  description = "The name of the cluster that will be created within the resource group"
  default = ""
}
variable "workload_worker_count" {
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
  default = "4.8"
}
variable "cluster_exists" {
  type = bool
  description = "Flag indicating if the cluster already exists (true or false)"
  default = false
}
variable "cluster_disable_public_endpoint" {
  type = bool
  description = "Flag indicating that the public endpoint should be disabled"
  default = true
}
variable "cluster_ocp_entitlement" {
  type = string
  description = "Value that is applied to the entitlements for OCP cluster provisioning"
  default = "cloud_pak"
}
variable "cluster_force_delete_storage" {
  type = bool
  description = "Attribute to force the removal of persistent storage associtated with the cluster"
  default = false
}
variable "cluster_tags" {
  type = string
  description = "Tags that should be added to the instance"
  default = "[]"
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
variable "ibm-vpc_name" {
  type = string
  description = "The name of the vpc instance"
  default = ""
}
variable "ibm-vpc_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default = true
}
variable "ibm-vpc_address_prefix_count" {
  type = number
  description = "The number of ipv4_cidr_blocks"
  default = 3
}
variable "ibm-vpc_address_prefixes" {
  type = string
  description = "List of ipv4 cidr blocks for the address prefixes (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.40.0.0/18\",\"10.50.0.0/18\",\"10.60.0.0/18\"]"
}
variable "ibm-vpc_base_security_group_name" {
  type = string
  description = "The name of the base security group. If not provided the name will be based on the vpc name"
  default = ""
}
variable "ibm-vpc_internal_cidr" {
  type = string
  description = "The cidr range of the internal network"
  default = "10.0.0.0/8"
}
variable "ibm-vpc-gateways_provision" {
  type = bool
  description = "Flag indicating that the gateway must be provisioned"
  default = true
}
variable "worker-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
}
variable "workload_worker_subnet_count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 3
}
variable "worker-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "worker"
}
variable "worker-subnets_ipv4_cidr_blocks" {
  type = string
  description = "List of ipv4 cidr blocks for the subnets that will be created (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.40.10.0/24\",\"10.50.10.0/24\",\"10.60.10.0/24\"]"
}
variable "worker-subnets_ipv4_address_count" {
  type = number
  description = "The size of the ipv4 cidr block that should be allocated to the subnet. If {ipv4_cidr_blocks} are provided then this value is ignored."
  default = 256
}
variable "worker-subnets_provision" {
  type = bool
  description = "Flag indicating that the subnet should be provisioned. If 'false' then the subnet will be looked up."
  default = true
}
variable "worker-subnets_acl_rules" {
  type = string
  description = "List of rules to set on the subnet access control list"
  default = "[{\"name\":\"allow-vpn-ingress\",\"action\":\"allow\",\"direction\":\"inbound\",\"source\":\"0.0.0.0/0\",\"destination\":\"10.0.0.0/8\"},{\"name\":\"allow-vpn-egress\",\"action\":\"allow\",\"direction\":\"outbound\",\"source\":\"10.0.0.0/8\",\"destination\":\"0.0.0.0/0\"}]"
}
variable "vpe-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
}
variable "vpe-subnets__count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 3
}
variable "vpe-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "vpe"
}
variable "vpe-subnets_ipv4_cidr_blocks" {
  type = string
  description = "List of ipv4 cidr blocks for the subnets that will be created (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.40.20.0/24\",\"10.50.20.0/24\",\"10.60.20.0/24\"]"
}
variable "vpe-subnets_ipv4_address_count" {
  type = number
  description = "The size of the ipv4 cidr block that should be allocated to the subnet. If {ipv4_cidr_blocks} are provided then this value is ignored."
  default = 256
}
variable "vpe-subnets_provision" {
  type = bool
  description = "Flag indicating that the subnet should be provisioned. If 'false' then the subnet will be looked up."
  default = true
}
variable "vpe-subnets_acl_rules" {
  type = string
  description = "List of rules to set on the subnet access control list"
  default = "[]"
}
variable "ingress-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
}
variable "ingress-subnets__count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 3
}
variable "ingress-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "ingress"
}
variable "ingress-subnets_ipv4_cidr_blocks" {
  type = string
  description = "List of ipv4 cidr blocks for the subnets that will be created (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.40.30.0/24\",\"10.50.30.0/24\",\"10.60.30.0/24\"]"
}
variable "ingress-subnets_ipv4_address_count" {
  type = number
  description = "The size of the ipv4 cidr block that should be allocated to the subnet. If {ipv4_cidr_blocks} are provided then this value is ignored."
  default = 256
}
variable "ingress-subnets_provision" {
  type = bool
  description = "Flag indicating that the subnet should be provisioned. If 'false' then the subnet will be looked up."
  default = true
}
variable "ingress-subnets_acl_rules" {
  type = string
  description = "List of rules to set on the subnet access control list"
  default = "[]"
}
variable "vpe-cos_sync" {
  type = string
  description = "Value used to synchronize dependencies between modules"
  default = ""
}
variable "ibm-transit-gateway_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "ibm-transit-gateway_provision" {
  type = bool
  description = "Flag indicating that the transit gateway must be provisioned"
  default = false
}
