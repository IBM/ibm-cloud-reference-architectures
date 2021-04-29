## mgmt_resource_group_name: The name of the resource group
#mgmt_resource_group_name=""

## ibmcloud_api_key: The IBM Cloud api token
#ibmcloud_api_key=""

## mgmt_resource_group_provision: Flag indicating that the resource group should be created
#mgmt_resource_group_provision="true"

## hpcs_resource_group_name: The name of the resource group
#hpcs_resource_group_name=""

## cs_resource_group_name: The name of the resource group
#cs_resource_group_name=""

## hpcs_region: Geographic location of the resource (e.g. us-south, us-east)
#hpcs_region=""

## hpcs_name_prefix: The prefix name for the service. If not provided it will default to the resource group name
#hpcs_name_prefix=""

## cs_name_prefix: The prefix name for the service. If not provided it will default to the resource group name
#cs_name_prefix=""

## region: The IBM Cloud region where the cluster will be/has been installed.
#region=""

## mgmt_name_prefix: The name of the vpc resource
#mgmt_name_prefix=""

## mgmt_ssh_vpn_public_key: The public key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_vpn_public_key=""

## mgmt_ssh_vpn_private_key: The private key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_vpn_private_key=""

## mgmt_ssh_vpn_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_vpn_public_key_file=""

## mgmt_ssh_vpn_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_vpn_private_key_file=""

## mgmt_ssh_bastion_public_key: The public key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_bastion_public_key=""

## mgmt_ssh_bastion_private_key: The private key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_bastion_private_key=""

## mgmt_ssh_bastion_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_bastion_public_key_file=""

## mgmt_ssh_bastion_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_bastion_private_key_file=""

## mgmt_ssh_scc_public_key: The public key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_scc_public_key=""

## mgmt_ssh_scc_private_key: The private key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_scc_private_key=""

## mgmt_ssh_scc_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_scc_public_key_file=""

## mgmt_ssh_scc_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
#mgmt_ssh_scc_private_key_file=""

## kms_key_id: The id of the root key in the KMS instance that will be used to encrypt the cluster.
#kms_key_id=""

## worker_count: The number of worker nodes that should be provisioned for classic infrastructure
#worker_count="3"

## gitops_dir: the value of gitops_dir
#gitops_dir=""

## mgmt_scc_registration_key: The registration key generated for the SCC collector. The collector must be set up with a *private* endpoint. The value can be created/retrieved here - https://cloud.ibm.com/security-compliance/settings?tab=collectors
#mgmt_scc_registration_key=""

