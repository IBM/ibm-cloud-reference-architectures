#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)

cd "${SCRIPT_DIR}/terraform"
terraform init
terraform destroy -auto-approve
