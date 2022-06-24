#!/usr/bin/env bash

#if command -v terragrunt 1> /dev/null 2> /dev/null; then
#  echo "y" | terragrunt run-all destroy || exit 1
#  exit
#fi

CI="$1"

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
    RUNNING_PROCESSES=$(ps -ef)
    VPN_RUNNING=$(echo "${RUNNING_PROCESSES}" | grep "openvpn --config")

    if [[ -n "${VPN_RUNNING}" ]]; then
      echo "VPN required but it is already running"
    elif command -v openvpn 1> /dev/null 2> /dev/null; then
      OVPN_FILE=$(find . -name "*.ovpn" | head -1)
      echo "Connecting to vpn with profile: ${OVPN_FILE}"
      sudo openvpn --config "${OVPN_FILE}" &
    elif [[ -n "${CI}" ]]; then
      echo "VPN connection required but unable to create the connection. Skipping..."
      continue
    else
      echo "Please connect to your vpn instance using the .ovpn profile within the 110-ibm-fs-edge-vpc directory and press ENTER to proceed."
      read throwaway
    fi
  fi

  echo "***** Destroying ${name} *****"

  cd "${name}" && \
    terraform init && \
    ./destroy.sh && \
    cd - 1> /dev/null || \
    exit 1
done
