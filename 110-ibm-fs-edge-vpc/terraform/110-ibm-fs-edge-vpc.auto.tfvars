## ibmcloud_api_key: The api key used to access IBM Cloud
#ibmcloud_api_key=""

## region: the value of region
#region=""

## cs_name_prefix: The prefix name for the service. If not provided it will default to the resource group name
#cs_name_prefix=""

## kms_region: Geographic location of the resource (e.g. us-south, us-east)
#kms_region=""

## kms_service: The name of the KMS provider that should be used (keyprotect or hpcs)
#kms_service="keyprotect"

## edge_name_prefix: The name_prefix used to build the name if one is not provided. If used the name will be `{name_prefix}-{label}`
#edge_name_prefix="base"

## kms_resource_group_name: The name of the resource group
#kms_resource_group_name=""

## at_resource_group_name: The name of the resource group
#at_resource_group_name=""

## edge_resource_group_name: The name of the resource group
#edge_resource_group_name=""

## cs_resource_group_name: The name of the resource group
#cs_resource_group_name=""

## common_tags: Common tags that should be added to the instance
#common_tags=""

## edge_ssh_bastion_public_key: The public key provided for the ssh key. If empty string is provided then a new key will be generated.
#edge_ssh_bastion_public_key=""

## edge_ssh_bastion_private_key: The private key provided for the ssh key. If empty string is provided then a new key will be generated.
#edge_ssh_bastion_private_key=""

## edge_ssh_bastion_public_key_file: The name of the file containing the public key provided for the ssh key. If empty string is provided then a new key will be generated.
#edge_ssh_bastion_public_key_file=""

## edge_ssh_bastion_private_key_file: The name of the file containing the private key provided for the ssh key. If empty string is provided then a new key will be generated.
#edge_ssh_bastion_private_key_file=""

## ingress-subnets__count: The number of subnets that should be provisioned
#ingress-subnets__count="3"

## bastion-subnets__count: The number of subnets that should be provisioned
#bastion-subnets__count="3"

## egress-subnets__count: The number of subnets that should be provisioned
#egress-subnets__count="3"

