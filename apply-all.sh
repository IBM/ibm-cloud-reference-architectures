#!/usr/bin/env bash

#if command -v terragrunt 1> /dev/null 2> /dev/null; then
#  echo "y" | terragrunt run-all apply || exit 1
#  exit
#fi

CI="$1"
PARALLELISM=10

find . -type d -maxdepth 1 | grep -vE "[.]/[.].*" | grep -vE "^[.]$" | grep -v workspace | sort | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.]/(.*)~\1~g")

  TYPE=$(grep "deployment-type/gitops" ./${name}/bom.yaml | sed -E "s~[^:]+: [\"'](.*)[\"']~\1~g")

  if [[ "${TYPE}" == "true" ]]; then
    PARALLELISM=3
    echo "***** Setting parallelism for gitops type deployment for step ${name} to ${PARALLELISM} *****"
    continue
  fi

  OPTIONAL=$(grep "apply-all/optional" ./${name}/bom.yaml | sed -E "s~[^:]+: [\"'](.*)[\"']~\1~g")

  if [[ "${OPTIONAL}" == "true" ]]; then
    echo "***** Skipping optional step ${name} *****"
    continue
  fi

  VPN_REQUIRED=$(grep "vpn/required" ./${name}/bom.yaml | sed -E "s~[^:]+: [\"'](.*)[\"']~\1~g")

  if [[ "${VPN_REQUIRED}" == "true" ]]; then
    RUNNING_PROCESSES=$(ps -ef)
    VPN_RUNNING=$(echo "${RUNNING_PROCESSES}" | grep "openvpn --config")

    if [[ -n "${VPN_RUNNING}" ]]; then
      echo "VPN required but it is already running"
    elif command -v openvpn 1> /dev/null 2> /dev/null; then
      OVPN_FILE=$(find . -name "*.ovpn" | head -1)

      if [[ -z "${OVPN_FILE}" ]]; then
        echo "VPN profile not found. Skipping ${name}"
        continue
      fi

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

  echo "***** Applying ${name} *****"

  cd "${name}" && \
    terraform init && \
    terraform apply -parallelism=$PARALLELISM -auto-approve && \
    cd - 1> /dev/null || \
    exit 1
done
