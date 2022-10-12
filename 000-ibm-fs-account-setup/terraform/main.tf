module "ibm-onboard-fs-account" {
  source = "github.com/terraform-ibm-modules/terraform-ibm-toolkit-onboard-fs-account?ref=v1.1.3"

  action = var.ibm-onboard-fs-account_action
  ibmcloud_api_key = var.ibmcloud_api_key
  mfa = var.ibm-onboard-fs-account_mfa
  region = var.region
  restrict_create_platform_apikey = var.ibm-onboard-fs-account_restrict_create_platform_apikey
  restrict_create_service_id = var.ibm-onboard-fs-account_restrict_create_service_id
}
