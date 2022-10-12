variable "ibmcloud_api_key" {
  type = string
  description = "The api key used to access IBM Cloud"
}
variable "region" {
  type = string
  description = "the value of region"
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
variable "private_endpoint" {
  type = string
  description = "Flag indicating that the service should be created with private endpoints"
  default = "true"
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
variable "edge_name_prefix" {
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
variable "kms_resource_group_name" {
  type = string
  description = "The name of the resource group"
}
variable "kms_resource_group_sync" {
  type = string
  description = "Value used to order the provisioning of the resource group"
  default = ""
}
variable "purge_volumes" {
  type = bool
  description = "Flag indicating that any volumes in the resource group should be automatically destroyed before destroying the resource group. If volumes exist and the flag is false then the destroy will fail."
  default = false
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
variable "edge_resource_group_name" {
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
variable "common_tags" {
  type = string
  description = "Common tags that should be added to the instance"
  default = "[]"
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
variable "flow_log_bucket_metrics_monitoring_crn" {
  type = string
  description = "The crn of the Metrics Monitoring instance"
  default = null
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
variable "suffix" {
  type = string
  description = "Value added to the generated name to ensure it is unique"
  default = ""
}
variable "ibm-secrets-manager_provision" {
  type = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default = false
}
variable "ibm-secrets-manager_kms_enabled" {
  type = bool
  description = "Flag indicating that kms encryption should be enabled for this instance"
  default = false
}
variable "ibm-secrets-manager_kms_private_endpoint" {
  type = bool
  description = "Flag indicating the KMS private endpoint should be used"
  default = true
}
variable "ibm-secrets-manager_name" {
  type = string
  description = "Name of the Secrets Manager. If not provided will be generated as $name_prefix-$label"
  default = ""
}
variable "ibm-secrets-manager_label" {
  type = string
  description = "Label used to build the Secrets Manager name if not provided."
  default = "sm"
}
variable "ibm-secrets-manager_private_endpoint" {
  type = bool
  description = "Flag indicating that the service should be access using private endpoints"
  default = true
}
variable "ibm-secrets-manager_create_auth" {
  type = bool
  description = "Flag indicating the service authorization should be created to allow this service to access the KMS service"
  default = true
}
variable "ibm-secrets-manager_trial" {
  type = bool
  description = "Flag indicating whether the instance to be deployed is to be a trial plan. "
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
  default = "[\"10.1.0.0/18\",\"10.2.0.0/18\",\"10.3.0.0/18\"]"
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
variable "ibm-vpc_tags" {
  type = string
  description = "Tags that should be added to the instance"
  default = "[]"
}
variable "ibm-vpc-gateways_provision" {
  type = bool
  description = "Flag indicating that the gateway must be provisioned"
  default = true
}
variable "ibm-vpc-gateways_tags" {
  type = string
  description = "Tags that should be added to the instance"
  default = "[]"
}
variable "edge_ssh_bastion_name" {
  type = string
  description = "(Optional) Name given to the ssh key instance. If not provided it will be generated using prefix_name"
  default = ""
}
variable "edge_ssh_bastion_label" {
  type = string
  description = "(Optional) Label used for the instance. It will be added to the name_prefix to create the name if the name is not provided."
  default = "bastion"
}
variable "edge_ssh_bastion_public_key" {
  type = string
  description = "The public key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "edge_ssh_bastion_private_key" {
  type = string
  description = "The private key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "edge_ssh_bastion_public_key_file" {
  type = string
  description = "The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "edge_ssh_bastion_private_key_file" {
  type = string
  description = "The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated."
  default = ""
}
variable "edge_ssh_bastion_rsa_bits" {
  type = number
  description = "The number of bits for the rsa key, if it will be generated"
  default = 3072
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
  default = "[\"10.1.10.0/24\",\"10.2.10.0/24\",\"10.3.10.0/24\"]"
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
  default = "[{\"name\":\"allow-vpn-ingress\",\"action\":\"allow\",\"direction\":\"inbound\",\"source\":\"0.0.0.0/0\",\"destination\":\"10.0.0.0/8\"},{\"name\":\"allow-vpn-egress\",\"action\":\"allow\",\"direction\":\"inbound\",\"source\":\"10.0.0.0/8\",\"destination\":\"0.0.0.0/0\"}]"
}
variable "ingress-subnets_tags" {
  type = string
  description = "Tags that should be added to the instance"
  default = "[]"
}
variable "bastion-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
}
variable "bastion-subnets__count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 3
}
variable "bastion-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "bastion"
}
variable "bastion-subnets_ipv4_cidr_blocks" {
  type = string
  description = "List of ipv4 cidr blocks for the subnets that will be created (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.1.20.0/24\",\"10.2.20.0/24\",\"10.3.20.0/24\"]"
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
variable "bastion-subnets_tags" {
  type = string
  description = "Tags that should be added to the instance"
  default = "[]"
}
variable "egress-subnets_zone_offset" {
  type = number
  description = "The offset for the zone where the subnet should be created. The default offset is 0 which means the first subnet should be created in zone xxx-1"
  default = 0
}
variable "egress-subnets__count" {
  type = number
  description = "The number of subnets that should be provisioned"
  default = 3
}
variable "egress-subnets_label" {
  type = string
  description = "Label for the subnets created"
  default = "egress"
}
variable "egress-subnets_ipv4_cidr_blocks" {
  type = string
  description = "List of ipv4 cidr blocks for the subnets that will be created (e.g. ['10.10.10.0/24']). If you are providing cidr blocks then a value must be provided for each of the subnets. If you don't provide cidr blocks for each of the subnets then values will be generated using the {ipv4_address_count} value."
  default = "[\"10.1.30.0/24\",\"10.2.30.0/24\",\"10.3.30.0/24\"]"
}
variable "egress-subnets_ipv4_address_count" {
  type = number
  description = "The size of the ipv4 cidr block that should be allocated to the subnet. If {ipv4_cidr_blocks} are provided then this value is ignored."
  default = 256
}
variable "egress-subnets_provision" {
  type = bool
  description = "Flag indicating that the subnet should be provisioned. If 'false' then the subnet will be looked up."
  default = true
}
variable "egress-subnets_acl_rules" {
  type = string
  description = "List of rules to set on the subnet access control list"
  default = "[]"
}
variable "egress-subnets_tags" {
  type = string
  description = "Tags that should be added to the instance"
  default = "[]"
}
variable "ibm-vpc-vpn-gateway_label" {
  type = string
  description = "The label for the server instance"
  default = "vpn"
}
variable "ibm-vpc-vpn-gateway_mode" {
  type = string
  description = "The optional mode of operation for the VPN gateway. Valid values are route or policy"
  default = null
}
variable "ibm-vpc-vpn-gateway_tags" {
  type = string
  description = "List of tags for the resource"
  default = "[]"
}
variable "ibm-vpc-vpn-gateway_provision" {
  type = bool
  description = "Flag indicating that the resource should be provisioned. If false the resource will be looked up."
  default = true
}
variable "ibm-vpn-server_resource_label" {
  type = string
  description = "The label for the resource to which the vpe will be connected. Used as a tag and as part of the vpe name."
  default = "vpn"
}
variable "ibm-vpn-server_vpnclient_ip" {
  type = string
  description = "VPN Client IP Range"
  default = "172.16.0.0/16"
}
variable "ibm-vpn-server_vpc_cidr" {
  type = string
  description = "CIDR for the private VPC the VPN is connected to."
  default = "10.0.0.0/12"
}
variable "ibm-vpn-server_dns_cidr" {
  type = string
  description = "CIDR for the DNS servers in the private VPC the VPN is connected to."
  default = "161.26.0.0/16"
}
variable "ibm-vpn-server_services_cidr" {
  type = string
  description = "CIDR for the services in the private VPC the VPN is connected to."
  default = "166.8.0.0/14"
}
variable "ibm-vpn-server_client_dns" {
  type = string
  description = "Comma-separated DNS IPs for VPN Client Use ['161.26.0.10','161.26.0.11'] for public endpoints, or ['161.26.0.7','161.26.0.8'] for private endpoints"
  default = "[\"161.26.0.7\",\"161.26.0.8\"]"
}
variable "ibm-vpn-server_auth_method" {
  type = string
  description = "VPN Client Auth Method. One of: certificate, username, certificate,username, username,certificate"
  default = "certificate"
}
variable "ibm-vpn-server_vpn_server_proto" {
  type = string
  description = "VPN Server Protocol. One of: udp or tcp"
  default = "udp"
}
variable "ibm-vpn-server_vpn_server_port" {
  type = number
  description = "VPN Server Port number"
  default = 443
}
variable "ibm-vpn-server_vpn_client_timeout" {
  type = number
  description = "VPN Server Client Time out"
  default = 3600
}
variable "ibm-vpn-server_enable_split_tunnel" {
  type = bool
  description = "VPN server Tunnel Type"
  default = true
}
variable "vsi-bastion_label" {
  type = string
  description = "The label for the server instance"
  default = "server"
}
variable "vsi-bastion_image_name" {
  type = string
  description = "The name of the image to use for the virtual server"
  default = "ibm-ubuntu-22-04-minimal-amd64-1"
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
variable "vsi-bastion_tags" {
  type = string
  description = "Tags that should be added to the instance"
  default = "[]"
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
variable "vsi-bastion_acl_rules" {
  type = string
  description = "List of rules to set on the subnet access control list"
  default = "[]"
}
variable "vsi-bastion_target_network_range" {
  type = string
  description = "The ip address range that should be used for the network acl rules generated from the security groups"
  default = "0.0.0.0/0"
}
variable "ibm-transit-gateway_name" {
  type = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default = ""
}
variable "ibm-transit-gateway_provision" {
  type = bool
  description = "Flag indicating that the transit gateway must be provisioned"
  default = true
}
