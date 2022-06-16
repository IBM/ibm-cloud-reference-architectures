#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)

if command -v terragrunt 1> /dev/null 2> /dev/null; then
  echo "y" | terragrunt run-all destroy || exit 1
  exit
fi

find . -type d -maxdepth 1 | grep -vE "[.]/[.].*" | grep -vE "^[.]$" | grep -v workspace | sort -r | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.]/(.*)~\1~g")

  if [[ ! -f "./${name}/terraform.tfstate" ]]; then
    echo "*** No state found for ${name}. Skipping ***"
    continue
  fi

  VPN_REQUIRED=$(grep "vpn/required" ./${name}/bom.yaml | sed -E "s~[^:]+: \"(.*)\"~\1~g")

  if [[ "${VPN_REQUIRED}" == "true" ]]; then
    "${SCRIPT_DIR}/start-vpn.sh"
  fi

  echo "***** Destroying ${name} *****"

  cd "${name}" && \
    terraform init && \
    ./destroy.sh && \
    cd - 1> /dev/null || \
    exit 1
done
