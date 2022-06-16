skip = true

terraform {
  source = "."

  before_hook "vpn" {
    commands     = ["apply", "plan", "destroy"]
    execute      = ["${get_parent_terragrunt_dir()}/check-vpn.sh", "${get_parent_terragrunt_dir()}", "${get_terragrunt_dir()}"]
  }
}
