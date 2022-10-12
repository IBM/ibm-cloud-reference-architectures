# Client 2 Site VPN

This is a terraform module that will provision a client-to-site VPN on IBM Cloud.  _Note: This is a beta offering that is not supported by the IBM cloud Terraform provider yet, so it is implemented using a `local-exec` provisioner with a bash script to handle resource creation and configuration.

This module will: 

- Download necessary CLI dependencies (`jq`)
- Create a group in a secrets manager instance
- Create a server and a client certificate and import them into the secrets manager group
- Update the ACL for the VPC subnet to allow for VPN ingress & egress
- Create a security group and security group rules for the VPN server instance
- Provision a VPN server
- Download a VPN Client profile and inject the client certificate so it is ready for use with an OpenVPN client

## Software dependencies

Dependencies:
- [CLIs](https://github.com/cloud-native-toolkit/terraform-util-clis)
- [Resource Group](https://github.com/cloud-native-toolkit/terraform-ibm-resource-group)
- [Certificate Manager](https://github.com/cloud-native-toolkit/terraform-ibm-cert-manager)
- [VPC Subnet](https://github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets)

### Command-line tools

- `terraform` - v1.2.8
- `jq`
- `ibmcloud`

### Terraform providers

None

## Example usage

```hcl-terraform
module "vpn_module" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-vpn-server"

  resource_group_name   = module.resource_group.name
  region                = var.region
  ibmcloud_api_key      = var.ibmcloud_api_key
  resource_label        = "client2site"
  secrets_manager_name  = module.secrets-manager.name
  vpc_id                = module.subnets.vpc_id
  subnet_ids            = module.subnets.ids
}
```

