#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)

if command -v terragrunt 1> /dev/null 2> /dev/null; then
  echo "y" | terragrunt run-all apply || exit 1
  exit
fi

find . -type d -maxdepth 1 | grep -vE "[.]/[.].*" | grep -vE "^[.]$" | grep -v workspace | sort | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.]/(.*)~\1~g")

  cd "${name}"

  if [[ -f "${SCRIPT_DIR}/check-vpn.sh" ]]; then
    "${SCRIPT_DIR}/check-vpn.sh"
  fi

  echo "***** Applying ${name} *****"

  terraform init && \
    terraform apply -auto-approve && \
    exit 1
done
