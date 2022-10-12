# TechZone Automation - IBM Cloud Reference Architecture

### Change Log

- **05/2022** - Automated validation of terraform & update to latest modules
- **04/2022** - Improved usability & update to latest modules
- **11/2021** - Updated to use Client-to-site VPN service (beta) instead of a VSI running a VPN server
- **11/2021** - Updated to support the Edge VPC infrastructure in addition to Management and Workload VPCs.
- **06/2021** - Initial release

> This collection of IBM Cloud terraform automation bundles has been crafted from a set of [Terraform modules](https://modules.cloudnativetoolkit.dev/) created by the IBM Ecosystem Engineering team part of the [IBM Ecosystem organization](https://www.ibm.com/partnerworld/public?mhsrc=ibmsearch_a&mhq=partnerworld). Please contact **Matthew Perrins** __mjperrin@us.ibm.com__, **Sean Sundberg** __seansund@us.ibm.com__, or **Andrew Trice** __amtrice@us.ibm.com__ for more details or raise an issue on the repository for bugs or feature requests.

The automation supports three reference architectures to establish a secure cloud environment that will enable the deployment and management of secure workloads.

Within this repository you will find a set of Terraform template bundles that embody best practices for provisioning and configuring cloud resources in an IBM Cloud cloud account. We recommend using this with an IBM Cloud [Enterprise sub-account](https://cloud.ibm.com/docs/account?topic=account-what-is-enterprise).

This `README.md` describes the SRE steps required to provision an environment that will scan cleanly with the Security and Compliance Centers NIST based profiles.

> The Security and Compliance scan currently has a set of known [exceptions](#exceptions) see below.

This suite of automation can be used for a Proof of Technology environment, or used as a foundation for production workloads with a fully working end-to-end cloud-native environment. The base environment provides a collection of shared services, an edge network, a management network, and a workload network. This automation contains includes OpenShift Developer Tools from the [Cloud-Native Toolkit project](https://cloudnativetoolkit.dev/)


**Shared services**

- IBM Key Protect _- For the highest level of security, you can also use a Hyper Protect Crypto Service_ instance
- IBM Log Analysis
- IBM Monitoring
- Activity Tracker
- Certificate Manager

**Edge network**

- Client to Site VPN server or Site to Site VPN Gateway
- Bastion server(s)

**Management network**

- Red Hat OpenShift cluster with SDLC tools provided from the [Cloud-Native Toolkit](https://cloudnativetoolkit.dev/)

**Workload network**

- Red Hat OpenShift cluster

**Developer Tools installed into OpenShift**

- OpenShift Pipelines (Tekton)
- OpenShift GitOps (ArgoCD)
- Artifactory
- SonarQube
- Swagger Editor
- Developer Dashboard ( Starter Kits Code Samples )
- Pre-validated Tekton Pipelines and Tasks
- CLI Tools to assit pipeline creation

This set of automation packages was generated using the open-source [`isacable`](https://github.com/cloud-native-toolkit/iascable) tool. This tool enables a [Bill of Material yaml](https://github.com/cloud-native-toolkit/automation-solutions/tree/main/boms/ibmcloud-ref-arch-fs) file to describe your IBM Cloud architecture, which it then generates the terraform modules into a package of infrastructure as code that you can use to accelerate the configuration of your IBM Cloud environment. Iascable generates standard terraform templates that can be executed from any terraform environment.

> The `iascable` tool is targeted for use by advanced SRE developers. It requires deep knowledge of how the modules plug together into a customized architecture. This repository is a fully tested output from that tool. This makes it ready to consume for projects.

The following diagram gives a visual representation of the what your IBM Cloud account will contain after the automation has been successfully executed.

## Reference Architecture

![Reference Architecture](./images/ibm-cloud-architecture.png)

Automation is provided in following Terraform packages that will need to be run in order. The bundles have been created this way to give the SRE team the most flexibility possible when building infrastructure for a project.

## Automation Stages

Clone this repository to access the automation to provision this reference architecture on the IBM Cloud. This repo contains the following defined _Bill of Materials_ or **BOMS** for short. They logically build up to deliver a set of IBM Cloud best practices. The reason for having them separate at this stage is to enable a layered approach to success. This enables SREs to use them in logical blocks. One set for Shared Services for a collection of **Edge**, **Management** and **Workload** VPCs or a number of **Workload** VPCs that maybe installed in separate regions.

### VPC with VSIs

| BOM ID | Name                                                  | Description                                                                                                           | Run Time |
| ------ |-------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------| -------- |
| 000    | [000 - Account Setup](./000-ibm-fs-account-setup)     | Set up account and provision a set of account-wide services. This is intended to only be run one time in an account | 5 Mins   |
| 100    | [100 - Shared Services](./100-ibm-fs-shared-services) | Provision a set of common cloud managed services that can be shared with a Edge, **Management** and **Workload** VPCs | 5 Mins   |
| 110    | [110 - Edge VPC](./110-ibm-fs-edge-vpc)               | Provision an **Edge VPC** with Client to Site VPN & Bastion                                                           | 10 Mins  |
| 120    | [120 - Management VPC](./120-ibm-fs-management-vpc)   | Provision a **Management VPC** and connect to Transit Gateway                                                         | 10 mins  |
| 140    | [140 - Workload VPC](./140-ibm-fs-workload-vpc)       | Provision a **Workload VPC** and connect to Transit Gateway                                                           | 10 mins  |

### VPC with Red Hat OpenShift

| BOM ID | Name                                                                              | Description                                                                                                                                                                   | Run Time |
| ------ |-----------------------------------------------------------------------------------| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| 000    | [000 - Account Setup](./000-ibm-fs-account-setup)                                 | Set up account and provision a set of account-wide services. This is intended to only be run one time in an account                                           | 5 Mins   |
| 100    | [100 - Shared Services](./100-ibm-fs-shared-services)                             | Provision a set of common cloud managed services that can be shared with a Edge, **Management** and **Workload** VPCs                                                         | 5 Mins   |
| 110    | [110 - Edge VPC](./110-ibm-fs-edge-vpc)                                           | Provision an **Edge VPC** with Client to Site VPN & Bastion                                                                                                                   | 10 Mins  |
| 130    | [130 - Management + OpenShift Cluster](./130-ibm-fs-management-vpc-openshift)     | Provision a **Management VPC** with and Red Hat OpenShift Cluster and connect to Transit Gateway                                                                              | 45 mins  |
| 150    | [150 - Workload + OpenShift Cluster](./150-ibm-fs-workload-vpc-openshift)         | Provision a **Workload VPC** with Red Hat OpenShift Cluster and connect to Transit Gateway                                                                                    | 45 mins  |
| 160    | [160 - Developer Tools into Management Cluster](./160-ibm-fs-openshift-dev-tools) | Provision a set of common CNCF developer tools into Red Hat OpenShift to provide a DevSecOps SDLC that support industry common best practices for CI/CD                       | 20 mins  |
| 165    | [165 - Workload Cluster setup](./165-ibm-fs-openshift-workload)                   | Binds the cluster to the IBM Logging and IBM Monitoring instances in shared services, sets up some basic cluster configuration, and provisions ArgoCD into the cluster for CD | 10 mins  |

### Configuration guidance

There are a couple of things to keep in mind when preparing to deploy the architectures that will impact the naming conventions:

#### Creating multiple Management or Workload deployments

If you are planning to create multiple instances of the Management or Workload architecture in the same account, the following must be accounted for:

- Each deployment should use different values for `name_prefix` to keep the resources isolated

## Prerequisites

1. Have access to an IBM Cloud Account, Enterprise account is best for workload isolation but if you only have a Pay Go account this set of terraform can be run in that level of account.

2. Download OpenVPN Client from https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-macos/#installing-a-client-application for your client device, this has been tested on MacOS

3. At this time the most reliable way of running this automation is with Terraform in your local machine either through a bootstrapped docker image or Virtual Machine. We provide both a [container image](https://github.com/cloud-native-toolkit/image-cli-tools) and a virtual machine [cloud-init](https://github.com/cloud-native-toolkit/sre-utilities/blob/main/cloud-init/cli-tools.yaml) script that have all the common SRE tools installed. 

We recommend using Docker Desktop if choosing the container image method, and Multipass if choosing the virtual machine method.   Detailed instructions for downloading and configuring both Docker Desktop and Multipass can be found in [RUNTIMES.md](./RUNTIMES.md)


## Setup

### Key Management

The first step in this automation is to provision a Key Management service instance.  By default, this Terraform automation will provision an instance of the Key Protect key management service.  Optionally, you can provision a Hyper Protect Crypto Services instance into the nominated account and initialise the key ceronmony by changing the `kms_service` tfvar value to `hpcs`. You can do this with the following automation. We recommend to follow the product docs to perform the quick initialization.

[Hyper Protect Cyrpto Service Documentation](https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-get-started)

For proof of technology environments we recommend using the `auto-init` feature. [Auto Init Documentation](https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-initialize-hsm-recovery-crypto-unit)

#### <a name="enable-financial-services-validated-account-flag"></a> Enable the account to use Financial Services Validated products

Enable your IBM Cloud account to use Financial Services Validated Products

1. Open the IBM Cloud console and click on **Manage** down arrow and select **Account** - https://cloud.ibm.com/account
2. After selecting **Account**,select **Account settings** from the left side menu - https://cloud.ibm.com/account/settings
3. Click **On** for the Financial Services Validated option.
4. Read the information about enabling the setting, and select **I understand and agree to these terms**. Click **On**.

### Setup

1. Clone this repository to your local SRE laptop or into a secure terminal. Open a shell into the cloned directory.
2. Copy `credentials.template` to `credentials.properties`.
3. Provide your IBM Cloud API key as the value for the `TF_VAR_ibmcloud_api_key` variable in `credentials.properties` (**Note:** `*.properties` has been added to `.gitignore` to ensure that the file containing the apikey cannot be checked into Git.)
4. Launch the automation runtime. 
    - If using *Docker Desktop*, run `./launch.sh`. This will start a container image with the prompt opened in the `/terraform` directory.
    - If using *Multipass*, run `mutlipass shell cli-tools` to start the interactive shell, and cd into the `/automation/{template}` directory, where  `{template}` is the folder you've cloned this repo. Be sure to run `source credentials.properties` once in the shell.
5. Determine what type of deployment you will be doing. There are currently two template FLAVORS available:
   - `full`: Full IBM Cloud reference architecture deployment, including a Key Protect instance.
   - `small`: IBM reference architecture scaled down for a POC environment deployment. This includes Key Protect and the clusters have been reduced to single region.
6. Determine which reference architecture you will be deploying. There are currently four  options available:
   - `vpc`: IBM Cloud - VPC with virtual servers reference architecture
   - `ocp-base`: IBM Cloud - VP with Red Hat OpenShift reference architecture (the base install without any configuration done to the management and workload clusters)
   - `ocp`: IBM Cloud - VPC with Red Hat OpenShift reference architecture with configured management and workload clusters
   - `all`: Will copy all the terraform bundles into your workspace bundles prefixed `000` to `170`
7. Run the `setup-workspace.sh -t {FLAVOR} -a {ARCH}` script to create a copy of the Terraform scripts in a `workspace/current` directory and generate the SSH keys needed for the various VSI instances. (**Note:** The command also accepts two optional arguments - `-r` fro "region" and `-n` for "name prefix". Both are used to populate the generated `terraform.tfvars` file.)
   ```
   ./setup-workspace.sh -t small -a all
   ```
8. Change the directory to the current workspace (e.g. `cd ../workspaces/current`) and follow the instructions in the README for the layer.
9. Update **terraform.tfvars** in the `../workspaces/current` directory with the appropriate values for your deployment. Note: The values are currently set up to separate resource groups for common services, edge, management, and workload resources. These can be changed to all use the same resource group, if desired.

## Terraform Apply

These instructions assume the "Setup" instructions in the previous section have already been performed.

### Apply the layers automatically

All the layers of the selected architecture can be applied automatically, one after the other, with a single command. Where the VPN is required for one of the layers to run, it will automatically be enabled.

1. Launch either Multipass or the container in Docker Desktop using the instructions in the setup section above.

2. The container should have opened in the `/terraform/workspace` as the working directory which should be mounted from repository directory on the host.
3. Assuming the `setup-workspace.sh` has already been run, change the directory to `/workspaces/current`. If not, run the `setup-workspace.sh` script again then change to the `/workspaces/current` directory.
4. Review the contents of "terraform.tfvars" by running `less terraform.tfvars`. A soft link to this file has created in each terraform subdirectory so the one file will provide the configuration for all the terraform.
5. Run `./apply-all.sh` from the `/workspaces/current` directory. The script will apply each of the layers in order. The entire process should take about two hours.

### Apply each architecture in the solution manually

1. Launch either Multipass or the container in Docker Desktop using the instructions in the setup section above.

2. The container should have opened in the `/terraform/workspace` as the working directory which should be mounted from repository directory on the host.
3. Assuming the `setup-workspace.sh` has already been run, change the directory to `/workspaces/current`. If not, run the `setup-workspace.sh` script again then change to the `/workspaces/current` directory.
4. Review the contents of "terraform.tfvars" by running `less terraform.tfvars`. A soft link to this file has created in each terraform subdirectory so the one file will provide the configuration for all the terraform.
5. For each terraform layer, perform the following steps:
    
    1. Change to the terraform directory that will be applied (e.g. `000-ibm-fs-account-setup` or `100-ibm-fs-common-services`).
    2. Initialize the environment with `terraform init`
    3. Apply the terraform with `terraform apply -auto-approve`. If all is configured properly you should not be prompted again and the terraform should run to completion.
6. It is recommended to run Terraform bundles in this order:
   - `000`
   - `110`
   - `130`
   - `150`
   - Connect to the VPN (see instructions below)
   - `160`
   - `165`

> **⚠️ Warning**: You will receive errors when executing `160` and `165` if you do not connect to the VPN. The error message will be similar to:
>
> ```
> Error: Error downloading the cluster config [mgmt-cluster]: Get "https://c109-e.private.us-east.containers.cloud.ibm.com:30613/.well-known/oauth-authorization-server": dial tcp 166.9.24.91:30613: i/o timeout
> ```
>
> If you then connect to the VPN and attempt to re-run the terraform template, you will then receive an error similar to:
>
> ```
> Error: Kubernetes cluster unreachable: invalid configuration: no configuration has been provided, try setting KUBERNETES_MASTER environment variable
> ```
>
> To get around this issue:
>
> 1. Make sure you are connected to the VPN
> 2. Delete the `terraform.tfstate` file
> 3. Re-run the `terraform apply` command

> We are working on an air gapped install of developer tools from within the private VPC network for Management Cluster.


## Terraform destroy

By default, the state of the configured environment is stored within each of the terraform layer directories. When you are ready to remove the provisioned resources, `terraform destroy` can be used to clean up the environment.

**Note**: If you run `setup-workspaces.sh` after applying the terraform, the contents of `/workspaces/current` will be moved to `/workspaces/workspace-{TIMESTAMP}` so the configuration and terraform state from a previous run is preserved.

### Destroy the layers automatically

All the layers of the selected architecture can be destroyed automatically, one after the other, with a single command. Where the VPN is required for one of the layers to run, it will automatically be enabled.

1. Launch either Multipass or the container in Docker Desktop using the instructions in the setup section above.

2. The container should have opened in the `/terraform/workspace` as the working directory which should be mounted from repository directory on the host.
3. Change to the directory where the terraform configuration from the previous run is located, `/workspaces/current` if `setup-workspace.sh` has not been executed since the last terraform run or the appropriate `/workspaces/workspace-{TIMESTAMP}` directory.
4. Run `./destroy-all.sh` from the current directory. The script will destroy each of the layers in order from last to first. The entire process should take about one hour.

### Destroy each layer in the solution manually

1. Launch either Multipass or the container in Docker Desktop using the instructions in the setup section above.

2. The container should have opened in the `/terraform/workspace` as the working directory which should be mounted from repository directory on the host.
3. Change to the directory where the terraform configuration from the previous run is located, `/workspaces/current` if `setup-workspace.sh` has not been executed since the last terraform run or the appropriate `/workspaces/workspace-{TIMESTAMP}` directory.
4. For each terraform layer, perform the following steps:

   1. Change to the terraform directory that will be applied (e.g. `000-ibm-fs-account-setup` or `100-ibm-fs-common-services`).
   2. Initialize the environment with `terraform init`
   3. Apply the terraform with `./destroy.sh`.
5. It is recommended to destroy the Terraform in the reverse order that they were applied. For example:
   - Connect to the VPN (see instructions below)
   - `165`
   - `160`
   - `150`
   - `130`
   - `110`
   - `000`

## Configure VPN

The following steps will help you setup the VPN server.

1. Copy the .ovpn profile that was generated from the `110-ibm-fs-edge-vpc` module to your local desktop.
   - If you are using `colima`, copy it from `/workspaces/current/110-ibm-fs-edge-vpc` to the `/terraform` directory and you will see it in your local operating system's file system.
   - If you are using `docker`, you can access it directly in the `workspace/110-ibm-fs-edge-vpc` folder.
2. Import the generated ovpn file from the `110-edge-vpc` step into your OpenVPN client and start the VPN connection. You should now have connectivity into the private VPC network and access to the edge VPC.

## Post Install of SCC Collectors

> **Limitations**: Currently, the managed SCC collector cannot be installed and configured using automation. As the APIs become available these steps will be updated.

The following post installation steps are required to enable scans of the infrastructure using the Security and Compliance Center. This configuration must only be performed one time.

1. Register the API key with [Security and Compliance Console](#register-scc-api-key) console.

2. [Create an IBM-managed collector with private endpoints](#generate-ssc-collector) by following the instructions below.

3. [Install the SCC collector](#install-scc-collector) into the already provisioned VSI's within the collector.

4. Once installed into the **Management** and **Workload** remember to activate them to start collecting compliance evidence for you Virtual Private Cloud configurations.

5. Review the scan results in the [Security and Compliance Center](https://cloud.ibm.com/security-compliance/overview)

### <a name="register-scc-apikey"></a> Register an API key with SCC

Set API Key for Security and compliance

1. Open the IBM Cloud console to the **Security and Compliance** tool - https://cloud.ibm.com/security-compliance/overview
2. Under **Manage Posture**, click **Configure** > **Settings**.
3. Open the **Credentials** tab and click **Create** to create a new credential. Provide the following values:
   - **Name**: Provide a descriptive name for the credential
   - **Purpose**: `Discovery/Collection`
4. Click **Next** to advance to the next page. Provide the following values:
   - **Credential type**: `IBM Cloud`
   - **IBM API key**: Enter your IBM Cloud API key
5. Press **Create** to register the API key.

### <a name="generate-ssc-collector"></a> Generate an IBM-managed SCC collector with private endpoints

An SCC collector is required to scan the infrastructure within the account for vulnerabilities.

1. Open the IBM Cloud console to the **Security and Compliance** tool - https://cloud.ibm.com/security-compliance/overview.
2. Under **Manage Posture**, click **Configure** > **Settings**.
3. On the **Collectors** tab, click **Create**. Provide `ibm-managed` for the collector **name** and press **Next**.
4. On the **Configuration** tab, provide the following values:
   - **Managed by**: `IBM`
   - **Endpoint type**: `Private`
5. Click **Create** to define the collector instance.
6. From the **Collectors** tab you will see the collector provisioning. It will take several minutes for the collector to be available.

## Configure Security and Compliance for an SCC scan

The following steps are required to set up an SCC scan of the environment after the SCC collectors have been installed. All of the following steps will be performed within the Security and Compliance center - https://cloud.ibm.com/security-compliance/overview

### 1. Create an inventory

1. Open the SCC inventory page - https://cloud.ibm.com/security-compliance/inventory
2. Click **Create** to create a new inventory
3. Provide a **name** for the inventory. Provide a name that identifies the environment you are scanning.
4. Press **Next**.
5. Check the collector(s) that have been registered for the environment. If the SCC collector steps have been performed successfully the collectors should be in **Ready** state.
6. Click "Save" to create the inventory.

### 2. Create a scope

A scope will define the collection of resources upon which the scan will be performed. Multiple scopes can be created for the same resources so how these scopes are defined is up to you. For now it is assumed you will have one scope per environment (i.e. one for management and one for workload).

1. Open the SCC scope page - https://cloud.ibm.com/security-compliance/scopes
2. Click **Create** to create a new scope
3. Provide a **name** for the scope (e.g. management).
4. Click **Next**
5. If you have previously created a scope and provided IBM Cloud credentials you can pick it from the list. If not click **Create +** to add a new one.
   1. Provide a name for the credential that will identify it for later use
   2. Select `Both` for the **Purpose**
   3. Press **Next**
   4. Pick `IBM Cloud` for the **Credential type**
   5. Provide your **IBM API key** for the account
   6. Press **Create** to create the credential
   7. Make sure the newly created credential is selected in the **Credentials** field of Scope dialog
6. Press **Next** on the Scope page to proceed to the "Collectors" pane
7. Select the collector(s) that will be used for the environment
8. Click **Next**
9. Click **Create** to create the scope

Creating the scope should kick off the Discovery scan which will take 10-30 minutes depending upon how many resources are in the environment.

### 3. Scope the inventory to the desired resources

After the initial Discovery scan, the scope will include **all** of the resources in the account. In most cases you will want to restrict the resources in the scope to those that are related to the particular environment.

1. Open the SCC scope page - https://cloud.ibm.com/security-compliance/scopes
2. Click on the name of the scope that you want to update.
3. In the "Inventory" section of the Scope page, click the **Edit** button.
4. Select/deselect the resources that should be included in the scope. Likely you will want to select just the resource group(s) that make up the environment. (Be sure to include the HPCS resource group, shared services, and environment resource group in scope.)
5. Click \*_Save_ to update the scope.

**Note:** An on-demand Discovery scan can be triggered if you need to update the inventory after changes in the environment. (See next step)

### 4. Run an on-demand scan

Now that the scope is set up, on-demand scans can be performed to get the validation results and update the inventory.

1. Open the SCC scope page - https://cloud.ibm.com/security-compliance/scopes
2. Find the scope against which you want to run a scan in the table.
3. Click the action menu on the right-hand side of the row (the vertical three dots) and select **On-demand scan**
4. Select `Validation` to run a validation scan. (This will also trigger a Discovery scan that runs before the validation.)
5. Select `IBM Cloud for Financial Services v0.1` for the **Profile**
6. Click **Create** to start the scan.

Depending on the number of resources in the scope, the scan will take 20-40 minutes.

### 5. View the scan results

1. Open the SCC scans page - https://cloud.ibm.com/security-compliance/scans
2. Once the scan is completed you will see an entry for the scan result in the page.
3. Click on the scan to see the results

### 6. Schedule regular scans of the environment

On-demand scans can be run at any point but you can also schedule scans to be regularly run against the environment.

1. Open the SCC scans page - https://cloud.ibm.com/security-compliance/scans
2. Click the **Scheduled scans** tab
3. Click **Schedule** to create a scheduled scan
4. Provide a **name** for the scan
5. Select `Validation` for the **Scan type**
6. Select the scope from the previous step for the **Scope**
7. Select `IBM Cloud for Financial Services v0.1` for the **Profile**
8. Click **Next**
9. Provide the schedule information for how frequently and for what duration the scan should run.
10. Click **Create** to create the scheduled scan

## Known Exceptions

The following exceptions are know when an SCC scan is performed on the reference architecure. These will need to be resolved for a production deployment. They are linked to the VPN client configuration.

### <a name="exceptions"></a> SCC Scan Exceptions

| Goal ID | Goal Description                                                                                                              | Severity | Exception description                                                                                                                                                                                                 |
| ------- | ----------------------------------------------------------------------------------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 3000404 | Check that the inbound rules in a VPC security group do not contain any rules that specify source IP 0.0.0.0/0 to SSH port 22 | Critical | The VPN security group requires access on port 22 from 0.0.0.0/0                                                                                                                                                      |
| 3000410 | Check that no VPC security groups have inbound ports open to the internet (0.0.0.0/0)                                         | Critical | The OpenVPN server requires access to the internet                                                                                                                                                                    |
| 3000411 | Check that no VPC security groups have outbound ports open to the internet (0.0.0.0/0)                                        | Critical | The SCC collector currently requires access to the internet                                                                                                                                                           |
| 3000441 | Check whether no VPC access control lists allow ingress from 0.0.0.0/0 to port 22                                             | Critical | VPC access control list does not restrict ingress from 0.0.0.0/0 to port 22                                                                                                                                           |
| 3000452 | Check whether no VPC network access control lists allow egress to 0.0.0.0/0 to any port                                       | Critical | The SCC collector and OpenShift cluster require egress to 0.0.0.0/0                                                                                                                                                   |
| 3000451 | Check whether no VPC network access control lists allow ingress from 0.0.0.0/0 to any port                                    | Critical | The VPN server requires ingress from 0.0.0.0/0                                                                                                                                                                        |
| 3000448 | Check whether Virtual Private Cloud (VPC) has no public gateways attached at the time of provisioning                         | High     | Public gateways give the subnets access to the internet. In the POT environment public gateways are currently needed for the SCC collector and for pipeline in the OpenShift cluster to access development resources. |
| 3000449 | Check whether Virtual Private Cloud (VPC) has no public gateways attached                                                     | High     | Same as previous                                                                                                                                                                                                      |
| 3000467 | Check whether subnet does not have public gateway attached.                                                                   | High     | Same as previous                                                                                                                                                                                                      |
| 3000454 | Check whether virtual server does not have a Floating IP                                                                      | High     | The OpenVPN virtual server instance uses a floating IP so that it can be accessed outside the private network for both SSH (port 22) access to configure VPN and VPN (port 1194) access.                              |
| 3000116 | Check whether Cloud Object Storage bucket resiliency is set to cross region                                                   | Medium   | Current conflict between encrypted buckets and cross-region buckets                                                                                                                                                   |
| 3000234 | Check whether Hyper Protect Crypto Services instance is enabled with a dual authorization deletion policy                     | Low      | For the POT environment, requireing dual authorization to delete a key would make cleanup and management much more difficult                                                                                          |

## Deploy First Application into Red Hat OpenShift

IBM is a multi-cloud company and we fully embrace consistent development tooling across cloud enviroments including IBM Cloud.

We recommend using the RedHat OpenShift developer tools for container based development. The Cloud-Native Toolkit gives a consistent developer experience and a set of SDLC tools (Software Delivery LifeCycle) that run inside on any OpenShift environment. These tools are installed as part of `160` and `170`. You can find more information about the toolkit here. [Cloud-Native Toolkit](https://cloudnativetoolkit.dev/)

**Prerequisites**

1. Ensure VPN is on
2. Follow the [Cloud Native Toolkit Dev-Setup guide](https://cloudnativetoolkit.dev/learning/dev-setup/) to configure dependencies.
3. Create your first application pipeline using OpenShift Pipelines (Tekton) using the [Cloud Native Toolkit Continuous Integration Fast-start tutorial](https://cloudnativetoolkit.dev/learning/fast-ci/).
4. Configure your first Continuous Delivery application using OpenShift GitOps (ArgoCD) by following the [Cloud Native Toolkit Countinuous Delivery Fast-start tutorial](https://cloudnativetoolkit.dev/learning/fast-cd/).

## (Optional) Cloud Satellite Setup & OpenShift Marketplace Add

Cloud Satellite can be used to deploy your application to a managed OpenShift environment anywhere on prem, on the Edge, or other Cloud providers.

Deploying Satellite involves the following steps:

1. Creating a Satellite location
2. Attach hosts to your location
3. Assigning hosts to the Satellite control plane

Detailed instructions for this can be found here in the [Satellite docs](https://cloud.ibm.com/docs/satellite?topic=satellite-getting-started)

## Adding RedHat Marketplace to a ROKS Satellite Cluster

Post installation of Cloud Satellite, the RedHat Marketplace is not added automatically within the OpenShift Cluster. This needs to be setup manually.

If you try and install one of the Red Hat Marketplace operators though you’ll find a problem with being unable to pull the operator image.

You must register your ROKS on Satellite cluster with the Red Hat Marketplace following instructions here: https://marketplace.redhat.com/en-us/workspace/clusters/add/register.

**NOTE**: Registering for the marketplace right now is currently only supported with a US based email address. After registering the marketplace will be available to all users of the cluster regardless of location.

This will create a new namespace `openshift-redhat-marketplace` and a global pull secret.

After step 5 in the Red Hat Marketplace instructions above, you need to restart your workers manually as the update pull secret script doesn’t get applied immediately.

**Prerequisite**

`oc cli version 4.6.23+`
available here: https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.6.23/

1.  List your satellite clusters you have access to:
    `ibmcloud ks cluster ls`

2.  List workers for your satellite cluster:
    `ibmcloud oc worker ls -c <cluster name from list above>`

3.  Restart each of the workers (**Note** this could potentially cause an application outage if done all at once)
    `ibmcloud oc worker reload -c gp-satellite-openshift-cluster -w <workerID>`

## Reference

### <a name="generate-ssh-keys"></a> Generate SSH Keys

You need to create a set of unique keys that will be configured for the various components that are provisioned by the Terraform automation.

1. The command to generate the ssh keys is `ssh-keygen -t rsa -b 3072 -N "" -f {name}`

2. You will want to run the command 6 times to generate the keys. If you are keeping with the names in the **terraform.tfvars** file then run the following:

   ```shell
   ssh-keygen -t rsa -b 3072 -N "" -f ssh-edge-bastion -q
   ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-scc -q
   ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-scc -q
   ```
