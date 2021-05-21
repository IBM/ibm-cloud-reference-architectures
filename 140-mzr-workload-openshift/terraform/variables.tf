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
variable "mgmt_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "mgmt_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = false
}
variable "workload_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "workload_resource_group_provision" {
  type = bool
  description = "Flag indicating that the resource group should be created"
  default = true
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
variable "hpcs_region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}
variable "hpcs_name_prefix" {
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
variable "region" {
  type = string
  description = "Geographic location of the resource (e.g. us-south, us-east)"
}
variable "cs_name_prefix" {
  type = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
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
variable "ibm-activity-tracker_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned"
  default = false
}
variable "ibm-activity-tracker_label" {
  type = string
  description = "Label used to build the resource name if one is not provided."
  default = "activity-tracker"
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
variable "kube-encrypt-auth_target_service_name" {
  type = string
  description = "The name of the service to which the source service will be authorization to access. This value is the name of the service as it appears in the service catalog."
  default = "hs-crypto"
}
variable "kube-encrypt-auth_target_resource_instance_id" {
  type = string
  description = "The instance id of the target service. This value is required if the authorization will be scoped to a specific service instance. If not provided the authorization will be scoped to the resource group or the account."
  default = null
}
variable "kube-encrypt-auth_target_resource_type" {
  type = string
  description = "The resource type of the target service. This value is used to define sub-types of services in the service catalog (e.g. flow-log-collector)."
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
variable "workload_name_prefix" {
  type = string
  description = "The name_prefix used to build the name if one is not provided. If used the name will be `{name_prefix}-{label}`"
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
variable "management-vpc_name" {
  type = string
  description = "The name of the vpc instance"
  default = ""
}
variable "mgmt_name_prefix" {
  type = string
  description = "The name of the vpc resource"
}
variable "management-vpc_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default = false
}
variable "management-vpc_address_prefix_count" {
  type = number
  description = "The number of ipv4_cidr_blocks"
  default = 0
}
variable "management-vpc_address_prefixes" {
  type = string
  description = "List of ipv4 cidr blocks for the address prefixes (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[]"
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
  default = 4
}
variable "ibm-vpc_address_prefixes" {
  type = string
  description = "List of ipv4 cidr blocks for the address prefixes (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.40.0.0/18\",\"10.50.0.0/18\",\"10.60.0.0/18\",\"10.2.0.0/18\"]"
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
variable "cross_region_location" {
  type = string
  description = "The cross-region location of the bucket. This value is optional. Valid values are (us, eu, and ap). This value takes precedence over others if provided."
  default = ""
}
variable "flow_log_bucket_storage_class" {
  type = string
  description = "Storage class of the bucket. Supported values are standard, vault, cold, flex, smart."
  default = "standard"
}
variable "vpe-subnets_gateways" {
  type = string
  description = "List of gateway ids and zones"
  default = "[]"
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
variable "vpe-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
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
  default = "[{\"name\":\"ingress-all\",\"action\":\"allow\",\"direction\":\"inbound\",\"source\":\"0.0.0.0/0\",\"destination\":\"0.0.0.0/0\"},{\"name\":\"egress-all\",\"action\":\"allow\",\"direction\":\"outbound\",\"source\":\"0.0.0.0/0\",\"destination\":\"0.0.0.0/0\"}]"
}
variable "bastion-subnets_gateways" {
  type = string
  description = "List of gateway ids and zones"
  default = "[]"
}
variable "bastion-subnets__count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 2
}
variable "bastion-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "bastion"
}
variable "bastion-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 1
}
variable "bastion-subnets_ipv4_cidr_blocks" {
  type = string
  description = "List of ipv4 cidr blocks for the subnets that will be created (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.50.30.0/24\",\"10.60.30.0/24\"]"
}
variable "bastion-subnets_ipv4_address_count" {
  type = number
  description = "The size of the ipv4 cidr block that should be allocated to the subnet. If {ipv4_cidr_blocks} are provided then this value is ignored."
  default = 256
}
variable "bastion-subnets_provision" {
  type = bool
  description = "Flag indicating that the subnet should be provisioned. If 'false' then the subnet will be looked up."
  default = true
}
variable "bastion-subnets_acl_rules" {
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
variable "workload_ssh_bastion_name" {
  type = string
  description = "(Optional) Name given to the ssh key instance. If not provided it will be generated using prefix_name"
  default = ""
}
variable "workload_ssh_bastion_label" {
  type = string
  description = "(Optional) Label used for the instance. It will be added to the name_prefix to create the name if the name is not provided."
  default = "bastion"
}
variable "workload_ssh_bastion_public_key" {
  type = string
  description = "The public key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "workload_ssh_bastion_private_key" {
  type = string
  description = "The private key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "workload_ssh_bastion_public_key_file" {
  type = string
  description = "The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "workload_ssh_bastion_private_key_file" {
  type = string
  description = "The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "workload_ssh_bastion_rsa_bits" {
  type = number
  description = "The number of bits for the rsa key, if it will be generated"
  default = 3072
}
variable "workload_ssh_scc_name" {
  type = string
  description = "(Optional) Name given to the ssh key instance. If not provided it will be generated using prefix_name"
  default = ""
}
variable "workload_ssh_scc_label" {
  type = string
  description = "(Optional) Label used for the instance. It will be added to the name_prefix to create the name if the name is not provided."
  default = "scc"
}
variable "workload_ssh_scc_public_key" {
  type = string
  description = "The public key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "workload_ssh_scc_private_key" {
  type = string
  description = "The private key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "workload_ssh_scc_public_key_file" {
  type = string
  description = "The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "workload_ssh_scc_private_key_file" {
  type = string
  description = "The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "workload_ssh_scc_rsa_bits" {
  type = number
  description = "The number of bits for the rsa key, if it will be generated"
  default = 3072
}
variable "worker-subnets__count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 3
}
variable "worker-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "worker"
}
variable "worker-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
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
  default = "[{\"name\":\"ingress-all\",\"action\":\"allow\",\"direction\":\"inbound\",\"source\":\"0.0.0.0/0\",\"destination\":\"0.0.0.0/0\"},{\"name\":\"egress-all\",\"action\":\"allow\",\"direction\":\"outbound\",\"source\":\"0.0.0.0/0\",\"destination\":\"0.0.0.0/0\"}]"
}
variable "scc-subnets__count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 1
}
variable "scc-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "scc"
}
variable "scc-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
}
variable "scc-subnets_ipv4_cidr_blocks" {
  type = string
  description = "List of ipv4 cidr blocks for the subnets that will be created (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.2.1.0/24\"]"
}
variable "scc-subnets_ipv4_address_count" {
  type = number
  description = "The size of the ipv4 cidr block that should be allocated to the subnet. If {ipv4_cidr_blocks} are provided then this value is ignored."
  default = 256
}
variable "scc-subnets_provision" {
  type = bool
  description = "Flag indicating that the subnet should be provisioned. If 'false' then the subnet will be looked up."
  default = true
}
variable "scc-subnets_acl_rules" {
  type = string
  description = "List of rules to set on the subnet access control list"
  default = "[{\"name\":\"ingress-all\",\"action\":\"allow\",\"direction\":\"inbound\",\"source\":\"0.0.0.0/0\",\"destination\":\"0.0.0.0/0\"},{\"name\":\"egress-all\",\"action\":\"allow\",\"direction\":\"outbound\",\"source\":\"0.0.0.0/0\",\"destination\":\"0.0.0.0/0\"}]"
}
variable "scc_kms_enabled" {
  type = bool
  description = "Flag indicating that the volumes should be encrypted using a KMS."
  default = true
}
variable "scc_image_name" {
  type = string
  description = "The name of the image that will be used in the Virtual Server instance"
  default = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}
variable "scc_init_script" {
  type = string
  description = "The script used to initialize the Virtual Server instance. If not provided the default script will be used."
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
variable "vsi-bastion_tags" {
  type = string
  description = "Tags that should be added to the instance"
  default = "[]"
}
variable "vsi-bastion_label" {
  type = string
  description = "The label for the server instance"
  default = "server"
}
variable "vsi-bastion_image_name" {
  type = string
  description = "The name of the image to use for the virtual server"
  default = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}
variable "vsi-bastion_profile_name" {
  type = string
  description = "Instance profile to use for the bastion instance"
  default = "cx2-2x4"
}
variable "vsi-bastion_allow_ssh_from" {
  type = string
  description = "An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the virtual server"
  default = "10.0.0.0/8"
}
variable "vsi-bastion_create_public_ip" {
  type = bool
  description = "Set whether to allocate a public IP address for the virtual server instance"
  default = false
}
variable "vsi-bastion_init_script" {
  type = string
  description = "Script to run during the instance initialization. Defaults to an Ubuntu specific script when set to empty"
  default = ""
}
variable "vsi-bastion_kms_enabled" {
  type = bool
  description = "Flag indicating that the volumes should be encrypted using a KMS."
  default = true
}
variable "vsi-bastion_auto_delete_volume" {
  type = bool
  description = "Flag indicating that any attached volumes should be deleted when the instance is deleted"
  default = true
}
variable "ibm-transit-gateway_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
