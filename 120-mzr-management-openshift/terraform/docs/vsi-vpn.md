# VSI OpenVPN module

IBM Virtual Private Cloud (VPC) comes with an additional layer of security as your workload can be completely hidden from the public internet. There are times, however, when you will want to get into this private network. A common practice is to use a Bastion host to jump into your VPC from a machine outside of the private network. Another option is to install VPN software inside your VPC to extend the secure VPC network to your local network.

OpenVPN is a popular VPN software solution that can be easily installed on a server and offer a simple way to reach all the servers in your VPC from your local machine.

This module deploys OpenVPN inside a CentOS 7.x VPC Virtual Server Instance (VSI) using Terraform and connects it to a Bastion server (provisioned separately) to use as a jump box. In this case the OpenVPN server IP is exposed to public internet but none of the other servers or resources are only accessible through the VPN tunnel. The OpenVPN instance allows for client-to-site VPN connections. 

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

## Inputs

| Name | Description | Type | Required | Default value |
|------|-------------|------|----------|---------------|
| resource\_group\_id | The id of the IBM Cloud resource group where the resources will be provisioned. | string | Yes |  |
| region | The IBM Cloud region where the resources will be provisioned (e.g. us-east, eu-gb). | string | Yes |  |
| ibmcloud\_api\_key | The IBM Cloud api token used to access the account and provision resources. | string | Yes |  |
| vpc\_name | The name of the existing VPC instance where the OpenVPN instance(s) will be provisioned. | string | Yes |  |
| subnet\_count | The number of subnets on the vpc instance that will be used for the OpenVPN instance(s). | number | Yes |  |
| subnets | The list of subnet objects where OpenVPN instance(s) will be provisioned. | list(object({id = string, zone = string, label = string})) | Yes |  |
| ssh\_key\_id | The id of a key registered with the VPC | string | Yes |  |
| ssh\_private\_key | The private key that is paired with ssh\_key\_id. | string | Yes |  |
| instance\_count | The number of Bastion/jump box instances routable by the OpenVPN server | number | Yes |  |
| instance_network_ids | The list of network interface ids for the Bastion/jump box servers. | list(string) | Yes |  |
| tags | The list of tags that will be applied to the OpenVPN vsi instances. | list(string) | No | [] |
| image\_name | Name of the image to use for the OpenVPN instance | string | No | ibm-centos-7-9-minimal-amd64-2 |
| profile\_name | Virtual Server Instance profile to use for the OpenVPN instance | string | No | cx2-2x4 |
| allow\_ssh\_from | An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the OpenVPN instance | string | No | 0.0.0.0/0 |
| security\_group\_rules | List of security group rules to set on the OpenVPN security group in addition to inbound SSH and VPC and outbound DNS, ICMP, and HTTP(s) rules | list(object({<br>    name=string,<br>    direction=string,<br>    remote=optional(string),<br>    ip_version=optional(string),<br>    tcp=optional(object({<br>      port_min=number,<br>      port_max=number<br>    })),<br>    udp=optional(object({<br>      port_min=number,<br>      port_max=number<br>    })),<br>    icmp=optional(object({<br>      type=number,<br>      code=optional(number)<br>    })),<br>})) | No | [] |
| 

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13

### Terraform providers

- IBM Cloud provider >= 1.17

## Module dependencies

This module makes use of the output from other modules:

- Resource group - github.com/cloud-native-toolkit/terraform-ibm-resource-group.git
  
    Provides the name and id of the resource group where the OpenVPN instance(s) will be provisioned
  
- VPC - github.com/cloud-native-toolkit/terraform-ibm-vpc.git
  
    Provides the name of the vpc where the OpenVPN instance(s) will be provisioned
  
- VPC Subnet - github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets.git
  
    Provides the subnets where the OpenVPN instance(s) should be provisioned
  
- VPC SSH - github.com/cloud-native-toolkit/terraform-ibm-vpc-ssh.git
  
    Provides the ssh key pair that should be used to access the OpenVPN instance(s)
  
- VSI Bastion - github.com/cloud-native-toolkit/terraform-vsi-bastion.git

    Provides the Bastion instances to which the OpenVPN instance(s) should be connected

## Example terraform

```hcl-terraform
module "openvpn" {
  resource_group_id   = module.resource_group.id
  region              = var.region
  ibmcloud_api_key    = var.ibmcloud_api_key
  vpc_name            = module.vpc.name
  subnet_count        = module.openvpn-subnets.count
  subnets             = module.openvpn-subnets.subnets
  ssh_key_id          = module.vpcssh.id
  ssh_private_key     = module.vpcssh.private_key
  instance_count      = module.bastion.instance_count
  instance_network_ids = module.bastion.network_interface_ids
}
```

## Usage

### Installation

When provisioning the OpenVPN instance a number of prerequisites must be met, namely provisioning all of the infrastructure upon which the OpenVPN server will be built. This can be done by hand or, better yet, make use of dependent modules to provision all of the pieces at once. The [test/stages](./test/stages) folder contains the terraform used to validate this module and provides a good example of how the combination of modules can be used to provide the full automation. 

Assuming the submodules are used to provision OpenVPN, one critical remaining component is the SSH keys. These keys should be generated, provided as input to the `vpc-ssh` module, and saved for future use. The private key will be used to authenticate to the OpenVPN in the future to provide configuration.

#### Generate SSH keys

SSH keys can be generated using the `ssh-keygen` command provided as part of OpenSSH. Run the following command to generate the key pair:

```shell
ssh-keygen -f openvpn -t rsa -b 3072 -N ""
```

The result of the command will be two files in the current directory: `openvpn` and `openvpn.pub`.

Provide the contents of these files as input to the `private_key` and `public_key` variables in the vpc-ssh module or provide `file(./openvpn)` and `file(./openvpn.pub)`

### Getting the public ip of the OpenVPN server

1. Open the Resources view on the IBM Cloud console - https://cloud.ibm.com/resources
2. Expand the *VPC Infrastructure* section.
3. Find the OpenVPN virtual server instance in the list and click on it. It will have a suffix of `openvpn-00`.
4. In the *Network interfaces* section at the bottom of the page, take note of the *Floating ip*. This is the public ip that can be used to access the OpenVPN server.

### Adding users to the OpenVPN server

1. Using the public ip of the OpenVPN server and the private key used to provision OpenVPN, establish a ssh session with the OpenVPN server:

    ```shell
    ssh -i ${private_key_file} root@${openvpn_ip}
    ```

2. Run the `openvpn-config.sh` script provided to configure the OpenVPN server.
   
    ```shell
    openvpn-config.sh
    ```
   
3.	Enter name of the user to whom you are giving access in the "Client Name" and press "Enter"
4.	When prompted to setup password for the client select option 2 - "Use a password for the client".
5. Enter the VPN password for the user.
6. The OpenVPN server authentication key file for the user is created and stored under directory /root/{Client Name}.ovpn
7. Either exit the shell or open another terminal window.
8. Secure copy (scp) the file to your local machine with the following command:

    ```shell
    scp -i ${private_key_file} root@${openvpn_ip}:/root/{Client Name}.ovpn .
    ```
9. Share the file with the OpenVPN user.
   
### Connecting the VPN client

1. Install [OpenVPN](https://openvpn.net/community-downloads/) client or [Tunnelblick](https://tunnelblick.net/cInstall.html) in your Desktop/Laptop as per instruction from the urls
2. Authenticate to OpenVPN server using OpenVPN client file "{Client Name}.ovpn"

Once the VPN client connection is established then you can access any of the resources available within the vpc network.
