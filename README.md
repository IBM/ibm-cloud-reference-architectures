# IBM Cloud for Financial Services - Terraform Automation

> This collection of IBM Cloud terraform automation bundles has been crafted from a set of [Terraform modules](https://github.com/cloud-native-toolkit/garage-terraform-modules/blob/main/MODULES.md) created by GSI Labs team part of the [Hybrid Cloud Ecosystem organization](https://w3.ibm.com/w3publisher/cloud-ecosystem). Please contact **Matthew Perrins** __mjperrin@us.ibm.com__ or **Sean Sundberg** __seansund@us.ibm.com__ for more details. 

The IBM Cloud defines a [reference architecture](https://test.cloud.ibm.com/docs/allowlist/framework-financial-services?topic=framework-financial-services-vpc-architecture-detailed-openshift) for IBM Cloud for Financial Services. This reference architecture establishes a secure cloud environment that will enable the deployment and management of requlatory compliant workloads.

This repository defines a set of Terraform automation bundles that embodies these best practices for provisioning cloud resources in an IBM Cloud Enterprise Sub account. 

This `README.md` will help describe the SRE steps required to provision an IBM Cloud for Financial Services environment that will scan cleanly to the Security and Compliance Centers NIST based profiles. 

> The Security and Compliance scan has a set of known [exceptions](#exceptions) see below 

This guide is optimized for Proof of Technology environments that will enable Global Partners and ISVs to configure a fully working end to end cloud-native environment. This will include Management with Bastion and Client to Site VPN. It will include Workload with OpenShift and support the Red Hat Software Delivery Lifecycle with the [Cloud-Native Toolkit](https://cloudnativetoolkit.dev/).

This set of automation packages was generated using the open-source [`isacable`](https://github.com/cloud-native-toolkit/iascable) tool. This tool enables a Bill of Material yaml file to described you IBM Cloud architecure, which it then generates the terraform modules into a package of infrastructure as code you can use to accelerate the configuration of you IBM Cloud environment. This can be run in IBM Schematics or from your local SRE laptop.

Automation is provided in following Terraform packages that will need to be run in order.

## Reference Architecture

The following is provisioned.

![Reference Architecture](./images/ibm-cloud-architecture.png)

## Automation Stages

Clone this repository to access the automation to provision this reference architecture on the IBM Cloud. This repo contains the following defined *Bill of Materials* or **BOMS** for short. They logically build up to deliver a set of IBM Cloud best practices. The reason for having them seperate at this stage is to enabled a layered approach to success. This enables SRE's to use them in logical blocks. One set for Common Services for a collection of **Management** and **Workload** VPCs or a number of **Workload** VPCs that maybe installed in seperate regions. 

| BOM ID | Name  | Description   | Run Time  | 
|---|---|---|---|
|  100 | [100 - Common Services](./100-common-services)  | Provision a set of common cloud managed services that can be shared with a **Management** and **Workload** VPCs pairs  | 5 Mins  |   
| 110  | [160 - Management VSI](./110-mzr-management)  | Provision a **Management VPC** with Client to Site VPN , Bastion and VSI  |  20 mins |   
|  120 | [120 - Management + OpenShift Cluster](./120-mzr-management-openshift) | Provision a **Management VPC** with Client to Site VPN , Bastion and Red Hat OpenShift Cluster  |  45 mins |   
| 130  | [160 - Workload VSI](./130-mzr-workload)  | Provision a **Workload VPC** with Transit Gateway connecting to **Management VPC**  |  20 mins |   
| 140  | [140 - Workload + OpenShift Cluster](./140-mzr-workload-openshift)  | Provision a **Workload VPC** with Red Hat OpenShift Cluster and Transit Gateway connecting to **Management VPC**  | 45 mins  |   
| 160  | [160 - Developer Tools into Management Cluster](./160-openshift-dev-tools)  | Provision a set of common CNCF developer tools into Red Hat OpenShift to provide a DevSecOps SDLC that support industry common best practices for CI/CD  |  20 mins |   
| 165  | [165 - Workload Cluster setup](./165-openshift-dev-tools)  | Binds the cluster to the IBM Logging and IBM Monitoring instances in common services, sets up some basic cluster configuration, and provisions ArgoCD into the cluster for CD | 10 mins |   

### Configuration guidance

There are a couple of things to keep in mind when preparing to deploy the architectures that will impact the naming conventions:

#### Creating multiple Common Service deployments

If you are planning to create multiple instances of the Common Services architecture in the same account, the following must be accounted for:

1. Only one Activity Tracker instance can be provisioned per region per account. If you are provisioning a second instance of Common Services then set `ibm-activity-tracker_provision="false"` in the **terraform.tfvars** file.
2. The Service Authorizations that allow the different services like Flow Logs, Block Storage, and Hyper Protect to communicate with each other are scoped at the account level instead of the resource group level due to some limitations and will error out with a conflict. The following values should be set to prevent conflicts:
   
    - `vsi-encrypt-auth_provision="false"`
    - `cos-encrypt-auth_provision="false"`

#### Creating multiple Management or Workload deployments

If you are planning to create multiple instances of the Management or Workload architecture in the same account, the following must be accounted for:

- Each deployment should use different values for `name_prefix` to keep the resources isolated

## Prerequisites

1. Have access to an IBM Cloud Account, Enterprise account is best for workload isolation but if you only have a Pay Go account this set of terraform can be run in that level of account.

2. Download OpenVPN Client from https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-macos/#installing-a-client-application for your client device, this has been tested on MacOS

3. At this time the most reliable way of running this automation is with Terraform in your local machine either through a bootstrapped docker image or with native tools installed. 

> The schematics service is producing intermittent issues.

## Setup

### Hyper Protect Crypto

The first step is provision a Hyper Protect Crypto Services instance into the nominated account and initialise the key ceronmony. You can do this with the following automation. We recommend to follow the product docs to perform the quick initialization.  

[Hyper Protect Cyrpto Service Documentation](https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-get-started)

For proof of technology environments we recommend using the `auto-init` feature. [Auto Init Documentation](https://cloud.ibm.com/docs/hs-crypto?topic=hs-crypto-initialize-hsm-recovery-crypto-unit)  


### Terraform IasC Automation

1. Clone this repository to your local SRE laptop and open a terminal to the cloned directory.
2. Copy `terraform.tfvars.template` to `terraform.tfvars`. This is the file you will use to provide input to the terraform scripts.
3. Run the `setup-workspace.sh` script to create a copy of the Terraform scripts in a `workspace/` directory and generate the SSH keys needed for the various VSI instances.
4. Update **terraform.tfvars** in the `workspace/` directoyr with the appropriate values for your deployment. Note: The values are currently set up to place everything in the same resource group. To use different resource groups, provide different values for each of the `*_resource_group_name` variables and comment out the `*_resource_group_provision="false"` values.

## Terraform Apply

1. Copy `credentials.template` to `credentials.properties`.
2. Provide your IBM Cloud API key as the value for the `ibmcloud.api.key` variable in `credentials.properties` (**Note:** `*.properties` has been added to `.gitignore` to ensure that the file containing the apikey cannot be checked into Git.)
3. From the root of the cloned repository directory, run `./launch.sh`. This will start a docker container that contains the required libraries to run the terraform scripts. 
4. The container should have opened in the `/terraform/workspace` as the working directory which should be mounted from repository directory on the host.
5. Change directory to the terraform directory that will be applied (e.g. `100-common-services`)
6. Initialize the environment with `terraform init`
7. Apply the terraform with `terraform apply -auto-approve`. If all is configured properly you should not be prompted again and the terraform should run to completion.
8. It is recommend to run Terraform bundles `100`, `120` , `140` and then `160` in sequence following the instruction listed above.  After running the `120 Management + OpenShift` architecture and before running `160 OpenShift Developer Tools`, the VPN server needs to be set up.

## Configure VPN

The following steps will help you setup the VPN server.

1. Open the IBM Console and go to the **VPC Virtual Server Images** page - https://cloud.ibm.com/vpc-ext/compute/vs
2. Find the VPN VSI instance in the list. (It will have a name like `{mgmt_name_prefix}-vpc-openvpn-00`.) Copy the value for the Floating IP.
3. Open a terminal to cloned repository directory (or wherever the SSH keys are located).
4. SSH into the OpenVPN server - `ssh -i ssh-mgmt-openvpn root@${floating_ip}`
5. Generate a new VPN configuration by running `openvpn-config.sh`. Follow the prompts to add a user. When the command has completed it will generate a file in `/root` on the remote host named after the userid you provided. The file name is printed at the end of the command output.
6. Exit the SSH session.
7. Use secure copy to bring the ovpn file down to your machine by running the following command - `scp -i mgmt-openvpn root@${floating_ip}:/root/${user}.ovpn .`
8. Import the ovpn file into your OpenVPN client and start the VPN connection. You  should now have connectivity into the private VPC network and access to the OpenShift Management Console.

## Post Install of SCC Collectors

> **Limitations** The SCC install script requires human input this is preventing this from being added to the automation. We are working with engineering to make this installation not require humans.

The following post installation steps are required. Install the Security and Compliance collector into the VSI instances that are within **Management** and **Workload** VPC networks.

1. Register the API key with  [Security and Compliance Console](#register-scc-api-key) console.

2. Create two SCC collectors with private endpoints following the [Generate SCC credentials](#generate-ssc) instructions below; one for Management BOM and one for Workload BOM. 

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

### <a name="generate-ssc"></a> Generate SCC credentials

An SCC registration key is required to register an SCC collector with the tool. For each collector instance a new registration key is required.

1. Open the IBM Cloud console to the **Security and Compliance** tool - https://cloud.ibm.com/security-compliance/overview.
2. Under **Manage Posture**, click **Configure** > **Settings**.
3. On the **Collectors** tab, click **Create**. Provide the following values:
    - **Name**: Enter a descriptive name for the collector
    - **Collector Endpoint**: `Private endpoint`
4. Click **Create** to define the collector instance.
5. From the **Collectors** tab, click on the collector you just created to expand the collector information.
6. Copy the value for the **Registration key**. This will be needed in terraform input to initialize the SCC collector.

### <a name="intall-scc-collector"></a> Install SCC Collector

Install the SCC Collector into the provisioned VSI

1. In order to register the SCC collecto, retrieve the private IP address of the SCC VSI instance from the VSI instances page in the IBM Cloud console - https://cloud.ibm.com/vpc-ext/compute/vs
2. Establish a VPN connection to the VPC cluster
3. Open a ssh session with the SCC VSI instance , Management is accesible like this `ssh -i ssh-mgmt-scc root@#{private-ip}`
   
    where:
    - `private-ip` is the ip address retrieved in the previous step
   
4. Run the scc collector registration script - `scc-collector.sh ${REGISTRATION_KEY}`. 

> **Note**: answer `No` to the proxy question

    where: 
    - `REGISTRATION_KEY` is the value shown after the SCC collector is created

5. Approve the collector After the script finishes running, you should do sub-step 10 of [Step 3](https://cloud.ibm.com/docs/security-compliance?topic=security-compliance-getting-started#gs-collector) which is to Approve the collection back in the Cloud console.

## Configure Security and Compliance for an SCC scan

The following steps are required to set up an SCC scan of the environment after the SCC collectors have been installed. All of the following steps will be performed within the Security and Compliance center - https://cloud.ibm.com/security-compliance/overview

### 1. Create an inventory

1. Open the SCC inventory page - https://cloud.ibm.com/security-compliance/inventory
2. Click **Create** to create a new inventory
3. Provide a **name** for the inventory. Provide a name that identifies the environment you are scanning.
4. Press **Next**.
5. Check the collector(s) that have been registered for the environment. If the SCC collector steps have been performed successfully they collectors should be in **Ready to install** state.
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
4. Select/deselect the resources that should be included in the scope. Likely you will want to select just the resource group(s) that make up the environment. (Be sure to include the HPCS resource group, common services, and environment resource group in scope.)
5. Click **Save* to update the scope.

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

The following exceptions are know when an SCC scan is performed on the reference architecure.



### <a name="exceptions"></a> SCC Scan Exceptions


|Goal ID|Goal Description|Severity|Exception description|
|-------|----------------|--------|---------------------|
|3000404|Check that the inbound rules in a VPC security group do not contain any rules that specify source IP 0.0.0.0/0 to SSH port 22|Critical|The VPN security group requires access on port 22 from 0.0.0.0/0|
|3000410|Check that no VPC security groups have inbound ports open to the internet (0.0.0.0/0)|Critical|The OpenVPN server requires access to the internet|
|3000411|Check that no VPC security groups have outbound ports open to the internet (0.0.0.0/0)|Critical|The SCC collector currently requires access to the internet|
|3000441|Check whether no VPC access control lists allow ingress from 0.0.0.0/0 to port 22|Critical|VPC access control list does not restrict ingress from 0.0.0.0/0 to port 22|
|3000452|Check whether no VPC network access control lists allow egress to 0.0.0.0/0 to any port|Critical|The SCC collector and OpenShift cluster require egress to 0.0.0.0/0|
|3000451|Check whether no VPC network access control lists allow ingress from 0.0.0.0/0 to any port|Critical|The VPN server requires ingress from 0.0.0.0/0|
|3000448 | Check whether Virtual Private Cloud (VPC) has no public gateways attached at the time of provisioning  | High |Public gateways give the subnets access to the internet. In the POT environment public gateways are currently needed for the SCC collector and for pipeline in the OpenShift cluster to access development resources.|
|3000449 | Check whether Virtual Private Cloud (VPC) has no public gateways attached | High | Same as previous|
|3000467|Check whether subnet does not have public gateway attached.|High|Same as previous|
|3000454|Check whether virtual server does not have a Floating IP|High|The OpenVPN virtual server instance uses a floating IP so that it can be accessed outside the private network for both SSH (port 22) access to configure VPN and VPN (port 1194) access.|
| 3000116 | Check whether Cloud Object Storage bucket resiliency is set to cross region | Medium | Current conflict between encrypted buckets and cross-region buckets |
|3000234 | Check whether Hyper Protect Crypto Services instance is enabled with a dual authorization deletion policy | Low | For the POT environment, requireing dual authorization to delete a key would make cleanup and management much more difficult |




# Deploy First Application into Red Hat OpenShift


**Prerequisites**

1. Ensure VPN is on
2. Install the Cloud-Native toolkit CLI

    `npm i -g \@ibmgaragecloud/cloud-native-toolkit-cli`

> **Note:** for the following example, a sample java app running on
liberty is used. The samples can be pulled from the Developer Dashboard-> Starter Kits

3.  Open a terminal window and login to OpenShift
4.  Change to the OpenShift project namespace of your application to
    deploy, if you don't have one, then create one first

    `oc project dev-project`

5.  Sync the project with the garage tools.

    `oc sync dev-project`

6.  Create the pipeline (Note: It will prompt you for your login
    credentials for your gitrepo the first time).

The pipeline creation can be run with or without options specified.
Without options, the tools will prompt you for the information.

**Without command line options**

`oc pipeline https://github.com/<gitorg>/<appname>`

**Options specified in command line**


```shell
oc pipeline --tekton https://github.com/<gitorg>/<appname>
--pipeline ibm-appmod-liberty -p scan-image=false -p health-endpoint=/
-p java-bin-path=CustomerOrderServicesApp/target -p lint-dockerfile=Yes
```

A pipeline will be created and started, also useful a url to the
new pipeline within the OpenShift console will be displayed.

Creating pipeline on openshift cluster in ts-libertyapp namespace

Next steps:

Tekton cli:

View PipelineRun info - tkn pr describe libertysampleapp-17957c4cef6
View PipelineRun logs - tkn pr logs -f libertysampleapp-17957c4cef6

OpenShift console:




View PipelineRun -
https://console-openshift-console.ivg-mgmt-cluster-19917-i000.us-east.containers.appdomain.cloud/k8s/ns/ts-libertyapp/tekton.dev\~v1beta1\~PipelineRun/libertysampleapp
```

3.  Create a gitops repository that is empty except for a default readme
    file. This is a new repository, when you create the repository check
    the box to initialize with a ReadMe file. For this example, it is
    called simply "gitops" but could be anything.

4.  Setup gitops for this repository:



```shell
oc gitops https://github.com/<gitorg>/<gitops-repo-name>

Setting the git credentials in the <project> namespace

Git credentials have already been stored for user: <user>

Project git repo: https://github.com/<gitorg>/<gitops-repo-name>.git

Branch: main
```

5.  Verify the setup succeeded by listing the configmap you will see a
    "gitops-repo" just created.

`oc get configmap`

6.  Create a new OpenShift project where your app will eventually be
    deployed, you may have one for staging, one for production. For this
    example, I created just one called: ts-libertyappstaging

7.  From the terminal, add the pull secrets to this new project:

`igc pull-secret ts-libertyappstaging`

8.  Setup ArgoCD for deploying to your target environment. Bring up the
    ArgoCD UI and setup the repository, Argo project, and Argo
    application configuration. The detailed instructions for this can be
    found here:
    <https://cloudnativetoolkit.dev/tools/argocd#register-the-gitops-repo-in-argocd>

    a.  In Settings, Configure a repository in ArgoCD.

        i.  Repository URL for this example is:
            https://github.com/tcskill/gitops

        ii. Set UI/PW, for Password you can use a git token

    b.  Configure ArgoCD Project

        i.  Set the Repository as your gitops repository and Destination
            as the local cluster with the OpenShift namespace the
            staging project created earlier (ts-libertyappstaging for this example)

    c.  Create a new ArgoCD Application. The Path will be the folder in your
    gitops repository that is created during the pipeline run.


## (Optional) Cloud Satellite Setup & OpenShift Marketplace Add

Cloud Satellite can be used to deploy your application to a managed OpenShift environment anywhere on prem, on the Edge, or other Cloud providers.

Deploying Satellite involves the following steps:

1. Creating a Satellite location
2. Attach hosts to your location
3. Assigning hosts to the Satellite control plane

Detailed instructions for this can be found here in the [Satellite docs](https://cloud.ibm.com/docs/satellite?topic=satellite-getting-started)

## Adding RedHat Marketplace to a ROKS Satellite Cluster

Post installation of Cloud Satellite, the RedHat Marketplace is not added automatically within the OpenShift Cluster.  This needs to be setup manually.

If you try and install one of the Red Hat Marketplace operators though you’ll find a problem with being unable to pull the operator image. 

You must register your ROKS on Satellite cluster with the Red Hat Marketplace following instructions here: https://marketplace.redhat.com/en-us/workspace/clusters/add/register. 

**NOTE**:  Registering for the marketplace right now is currently only supported with a US based email address.  After registering the marketplace will be available to all users of the cluster regardless of location.

This will create a new namespace `openshift-redhat-marketplace` and a global pull secret.

After step 5 in the Red Hat Marketplace instructions above, you need to restart your workers manually as the update pull secret script doesn’t get applied immediately.

**Prerequisite**

`oc cli version 4.6.23+`
available here: https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.6.23/

1.	 List your satellite clusters you have access to:
`ibmcloud ks cluster ls`

2.	 List workers for your satellite cluster:
`ibmcloud oc worker ls -c <cluster name from list above>`

3.	Restart each of the workers (**Note** this could potentially cause an application outage if done all at once)
`ibmcloud oc worker reload -c gp-satellite-openshift-cluster -w <workerID>`


## Reference

### <a name="generate-ssh-keys"></a> Generate SSH Keys

You need to create a set of unique keys that will be configured for the various components that are provisioned by the Terraform automation.

1. The command to generate the ssh keys is `ssh-keygen -t rsa -b 3072 -N "" -f {name}`

2. You will want to run the command 6 times to generate the keys. If you are keeping with the names in the **terraform.tfvars** file then run the following:

    ```shell
    ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-openvpn
    ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-bastion
    ssh-keygen -t rsa -b 3072 -N "" -f ssh-mgmt-scc
    ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-openvpn
    ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-bastion
    ssh-keygen -t rsa -b 3072 -N "" -f ssh-workload-scc
    ```

## Troubleshooting


