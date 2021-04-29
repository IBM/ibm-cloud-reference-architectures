## region: The IBM Cloud region where the cluster will be/has been installed.
region="us-east"

## cs_resource_group_name: The name of the resource group
cs_resource_group_name="my-test"

#cs_resource_group_provision="false"

## cs_name_prefix: The prefix name for the service. If not provided it will default to the resource group name
cs_name_prefix="common"

## hpcs_resource_group_name: The name of the resource group
hpcs_resource_group_name="cre-core-management"

## hpcs_region: Geographic location of the resource (e.g. us-south, us-east)
hpcs_region="us-east"
hpcs_name="HPCS-common"
hpcs_name_prefix="hpcs-common"

## mgmt_resource_group_name: The name of the resource group
mgmt_resource_group_name="test"

mgmt_resource_group_provision="false"

## mgmt_name_prefix: The name of the vpc resource
mgmt_name_prefix="mgmt"

## mgmt_ssh_vpn_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
mgmt_ssh_vpn_public_key_file="ssh-mgmt-openvpn.pub"

## mgmt_ssh_vpn_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
mgmt_ssh_vpn_private_key_file="ssh-mgmt-openvpn"

## mgmt_ssh_bastion_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
mgmt_ssh_bastion_public_key_file="ssh-mgmt-bastion.pub"

## mgmt_ssh_bastion_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
mgmt_ssh_bastion_private_key_file="ssh-mgmt-bastion"

## mgmt_ssh_scc_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
mgmt_ssh_scc_public_key_file="ssh-mgmt-scc.pub"

## mgmt_ssh_scc_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
mgmt_ssh_scc_private_key_file="ssh-mgmt-scc"

## mgmt_scc_registration_key: The registration key generated for the SCC collector. The collector must be set up with a *private* endpoint. The value can be created/retrieved here - https://cloud.ibm.com/security-compliance/settings?tab=collectors
mgmt_scc_registration_key=""

## workload_resource_group_name: The name of the resource group
workload_resource_group_name="test"

## workload_resource_group_provision: Flag indicating that the resource group should be created
workload_resource_group_provision="false"

## workload_name_prefix: The prefix name for the service. If not provided it will default to the resource group name
workload_name_prefix="workload"

## workload_ssh_vpn_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
workload_ssh_vpn_public_key_file="ssh-workload-openvpn.pub"

## workload_ssh_vpn_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
workload_ssh_vpn_private_key_file="ssh-workload-openvpn"

## workload_ssh_bastion_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
workload_ssh_bastion_public_key_file="ssh-workload-bastion.pub"

## workload_ssh_bastion_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
workload_ssh_bastion_private_key_file="ssh-workload-bastion"

## workload_ssh_scc_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
workload_ssh_scc_public_key_file="ssh-workload-scc.pub"

## workload_ssh_scc_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
workload_ssh_scc_private_key_file="ssh-workload-scc"

## workload_scc_registration_key: The registration key generated for the SCC collector. The collector must be set up with a *private* endpoint. The value can be created/retrieved here - https://cloud.ibm.com/security-compliance/settings?tab=collectors
workload_scc_registration_key=""

kms_key_id=""