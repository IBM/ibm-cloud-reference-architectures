# Install SCC

## Introduction
This example will create a ubuntu VSI and install the Security and Compliance Center collector.  This will help with most of the sub-steps in [Step 3 in the SCC cloud docs](https://cloud.ibm.com/docs/security-compliance?topic=security-compliance-getting-started#gs-collector) but, you will still need to do the rest of the steps, like creating scopes and scans, manually.

### Prerequisites

* Terraform 0.13 or higher
* IBM API Key
* An ssh key object already available in the IBM Cloud in the region where the VSI will be provisioned.  
* A VPC into which a subnet and VSI will be provisioned.
* Complete [Step 2 in the cloud docs](https://cloud.ibm.com/docs/security-compliance?topic=security-compliance-getting-started#gs-credentials) to store your credentials for the collector.
* Follow [Step 3 in the cloud docs](https://cloud.ibm.com/docs/security-compliance?topic=security-compliance-getting-started#gs-collector) to create a collector.  You only need to do sub-steps 1 and 2 in this section.  You do not need to download the collector script, but you do need to save the `registration key` and pass it to this terraform.


### Input Variables

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| ibmcloud_api_key | API Key used to provision resources.  Your key must be authorized to perform the actions in this script. | string | N/A | yes |
| base_name | prefix used in name of all provisioned resources. | string | N/A | yes |
| resource_group_id | The id of the resource group in which to provision all resources | string | N/A | yes |
| region | Must be the same region as the vpc. | string | us-south | no |
| zone | Zone in which to provision all resources.  Must be in the same region as the vpc. | string | us-south | no |
| vpc_id | VPC id of the VPC to use  | string | N/A | yes |
| ssh_key_id | The id of the ssh key that you will use to access the VSI | string | N/A | yes |
| ssh_private_key_file | The file with your private key.  This is used to remote-exec to the VSI after it's created and run the necessary shell scripts. | string | "~/.ssh/id_rsa" | yes (if it's in a different file than default) |
| scc_registration_key | string | The registration key used for running the collector | N/A | yes |

### Output Variables

| Name | Description |
| ---- | ----------- |
| vsi_private_ip  | The private ip of the vsi created |
| vsi_floating_ip | The floating ip of the vsi created |
| vsi_subnet     | The cidr of the subnet created |
| vsi_security_group_id | The id of the security group on the vsi |
| vsi_ssh_inboud_rule_id | The id of the security group rule that allows inbound ssh traffic |
| DISABLE_SSH | Command for removing the ssh rule on the security group to prevent inbound ssh traffic |


### Security Considerations

The VSI is running ubuntu and has disabled PasswordAuthentication over ssh and the root password is deleted.  
However, the security group on the VSI permits inbound ssh (port 22) from 0.0.0.0/0.  This was needed during the terraform execution to enable remote execution of scripts on the server.  Since all communication from the collector is outbound, you can remove this rule from the security group if you don't need to log into the machine.  See the output variable `DISABLE_SSH` for the command to do this.

Note that the VSI has a floating ip.  This is required for egress, unless there is a public gateway on the subnet.  


## Terraform Version
Tested with Terraform v0.13


## Running the configuration

Rename terraform.tfvars.template to terraform.tfvars and fill in all required variables

Then run:

```shell
terraform init
```

```shell
terraform apply
```
 
After the script finishes running, you should do sub-step 10 of [Step 3](https://cloud.ibm.com/docs/security-compliance?topic=security-compliance-getting-started#gs-collector) which is to Approve the collection back in the Cloud console.

From here you can proceed with the rest of the steps, setting up scopes and scans.
