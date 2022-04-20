# Sealed Secret Cert module

Module to collect or create a certificate and private key used with the sealed secrets service. The sealed secrets service
is used to store confidential information in a GitOps repository as encrypted SealedSecret resources. When the SealedSecret
resources are deployed to the cluster, the Kube Seal operator decrypts the contents of the SealedSecret and generates a 
Secret.

In order for the encryption process to work, the SealedSecret content must be encrypted using at public certificate and
the Kube Seal process will decrypt the content using the matching private key that has been provided to the cluster as a 
secret.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v14

### Terraform providers

- tls provider

## Module dependencies

None

## Example usage

```hcl-terraform
module "cert" {
  source = "github.com/cloud-native-toolkit/terraform-util-sealed-secret-cert.git"

  private_key_file = var.private_key_file
  cert_file        = var.cert_file
}
```

