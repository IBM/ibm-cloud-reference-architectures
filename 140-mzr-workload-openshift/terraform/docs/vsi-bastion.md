# VSI Bastion module

IBM Virtual Private Cloud (VPC) comes with an additional layer of security as your workload can be completely hidden from the public internet. There are times, however, when you will want to get into this private network. A common practice is to use a Bastion host to jump into your VPC from a machine outside of the private network. Another option is to install VPN software inside your VPC to extend the secure VPC network to your local network.

OpenVPN is a popular VPN software solution that can be easily installed on a server and offer a simple way to reach all the servers in your VPC from your local machine.

This module deploys OpenVPN inside a VPC Virtual Server Instance (VSI) using Terraform and Ansible.

<table cellspacing="10" border="0">
  <tr>
    <td>
      <img src="docs/architecture.png" />
    </td>
    <td>
      <img src="docs/openvpn.png" />
    </td>
  </tr>
</table>


## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.17

## Module dependencies

This module makes use of the output from other modules:

- VPC - github.com/cloud-native-toolkit/terraform-ibm-vpc

## Example usage

```hcl-terraform
module "bastion" {
  source = "github.com/cloud-native-toolkit/terraform-vsi-bastion.git?ref=v1.0.0"

  resource_group_name = var.resource_group_name
  region              = var.region
  name_prefix         = var.name_prefix
  ibmcloud_api_key    = var.ibmcloud_api_key
  vpc_name            = module.vpc.name
  subnet_count        = module.vpc.subnet_count
}
```

