# IBM Onboard FS account

Module to automate the configuration of an IBM Cloud account with required FS settings. There are a number of settings required. There are a number of settings that need to be made on the account for FS compliance but currently only a subset of the settings can be automated. The list of settings and manual setup steps are provided below:



## Settings

### Account settings

https://cloud.ibm.com/account/settings

- Financial Services Validated (**Manual**)
- Virtual routing and forwarding (**Manual**)
- Service endpoints (**Manual**)

### IAM settings

https://cloud.ibm.com/iam/settings

- Multi-factor authentication (**Automated**)
- Restrict user list visibility (**Manual**)
- Restrict API key creation* (**Automated**)
- Restrict service ID creation* (**Automated**)

**Note**: When "Restrict API key creation" and "Restrict service ID creation" are enabled, the corresponding "User API key creator" and "Service ID creator" IAM policies will need to be assigned to users via an access group.

## Manual setup steps

### Financial Services Validated

1. Open the Account Settings page - https://cloud.ibm.com/account/settings
2. Click the **On** button for the "Financial Services Validated" section

### Virtual routing and forwarding

1. Open the Account Settings page - https://cloud.ibm.com/account/settings
2. Click the **Create case** button under "Virtual routing and forwarding"
3. Submit the case. (No other information is required in the case)

### Service endpoints

1. Open the Account Settings page - https://cloud.ibm.com/account/settings
2. Once "Virtual routing and forwarding" has been enabled, the option to enable "Service endpoints" is available.
3. Click the **On** button to turn service endpoints on.

### Restrict user list visibility

1. Open the IAM settings - https://cloud.ibm.com/iam/settings
2. Click the toggle next to "Restrict user list visibility"

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v13
- ibmcloud cli

### Terraform providers

- IBM Cloud provider >= 1.18

## Module dependencies

- None

## Example usage

[Refer test cases for more details](test/stages/stage-onboard-fs-cloud.tf)

```hcl-terraform
terraform {
   required_providers {
      ibm = {
         source = "ibm-cloud/ibm"
      }
   }
   required_version = ">= 0.13"
}

provider "ibm" {
   region = var.region
   ibmcloud_api_key = var.ibmcloud_api_key
}

module "ibm_iam_account_settings" {
   source = "github.com/ibm-garage-cloud/terraform-ibm-account-access-group"
   
   region              = var.region
   ibmcloud_api_key    = var.ibmcloud_api_key
   mfa = var.mfa
   restrict_create_service_id = var.restrict_create_service_id
   restrict_create_platform_apikey = var.restrict_create_platform_apikey
}
```

Defines the MFA trait for the account. Valid values:

    NONE - No MFA trait set
    TOTP - For all non-federated IBMId users
    TOTP4ALL - For all users
    LEVEL1 - Email-based MFA for all users
    LEVEL2 - TOTP-based MFA for all users
    LEVEL3 - U2F MFA for all users



Defines whether or not creating platform API and Service Id is access controlled. Valid values:

    RESTRICTED - to apply access control
    NOT_RESTRICTED - to remove access control
    NOT_SET - to 'unset' a previous set value


container registry plateform-matrics
   --enable   Enable the setting for your account.
   --disable  Disable the setting for your account.
   --status   Display whether the setting is enabled for your account.

