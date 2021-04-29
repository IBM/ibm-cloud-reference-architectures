## resource_group_name: The name of the resource group
resource_group_name="sms-vpn2"
resource_group_provision="false"

## ibmcloud_api_key: The IBM Cloud api token
#ibmcloud_api_key=""

## hpcs_resource_group_name: The name of the resource group
hpcs_resource_group_name="cre-core-management"

## cs_resource_group_name: The name of the resource group
cs_resource_group_name="common-services"
cs_region="us-east"
cs_name_prefix="common"

## hpcs_region: Geographic location of the resource (e.g. us-south, us-east)
hpcs_region="us-east"
hpcs_name="HPCS-common"

## name_prefix: The prefix name for the service. If not provided it will default to the resource group name
name_prefix="sms-vpn-mgmt"

## region: The IBM Cloud region where the cluster will be/has been installed.
region="us-east"

## ssh-vpn_public_key: The public key provided for the ssh key. If empty string is provided then a new key will be generated.
ssh-vpn_public_key=""
ssh-vpn_public_key_file="openvpn.pub"

## ssh-vpn_private_key: The private key provided for the ssh key. If empty string is provided then a new key will be generated.
ssh-vpn_private_key=""
ssh-vpn_private_key_file="openvpn"

## ssh-bastion_public_key: The public key provided for the ssh key. If empty string is provided then a new key will be generated.
ssh-bastion_public_key=""
ssh-bastion_public_key_file="bastion.pub"

## ssh-bastion_private_key: The private key provided for the ssh key. If empty string is provided then a new key will be generated.
ssh-bastion_private_key=""
ssh-bastion_private_key_file="bastion"

## ssh-scc_public_key: The public key provided for the ssh key. If empty string is provided then a new key will be generated.
ssh-scc_public_key=""
ssh-scc_public_key_file="scc.pub"

## ssh-scc_private_key: The private key provided for the ssh key. If empty string is provided then a new key will be generated.
ssh-scc_private_key=""
ssh-scc_private_key_file="scc"

## scc_registration_key: The registration key generated for the SCC collector. The collector must be set up with a *private* endpoint. The value can be created/retrieved here - https://cloud.ibm.com/security-compliance/settings?tab=collectors
scc_registration_key="9f6886c4-d3c3-41ae-94f0-ede4de9a2ce9"
