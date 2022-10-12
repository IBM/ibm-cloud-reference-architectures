#!/bin/bash

# IBM GSI Ecosystem Lab

SCRIPT_DIR="$(cd $(dirname "$0"); pwd -P)"
SRC_DIR="${SCRIPT_DIR}/automation"

AUTOMATION_BASE=$(basename "${SCRIPT_DIR}")

if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
  echo "Usage: launch.sh [{docker cmd}] [--pull]"
  echo "  where:"
  echo "    {docker cmd} is the docker command that should be used (e.g. docker, podman). Defaults to docker"
  echo "    --pull is a flag indicating the latest version of the container image should be pulled"
  exit 0
fi

DOCKER_CMD="docker"
if [[ -n "$1" ]] && [[ "$1" != "--pull" ]]; then
  DOCKER_CMD="${1:-docker}"
fi

if [[ ! -d "${SRC_DIR}" ]]; then
  SRC_DIR="${SCRIPT_DIR}"
fi

# check if colima is installed, and apply dns override if no override file already exists
if command -v colima &> /dev/null
then
  if [ ! -f ~/.lima/_config/override.yaml ]; then
    echo "applying colima dns override..."

    COLIMA_STATUS="$(colima status 2>&1)"
    SUB='colima is running'
    if [[ "$COLIMA_STATUS" == *"$SUB"* ]]; then
      echo "stopping colima"
      colima stop
    fi

    echo "writing ~/.lima/_config/override.yaml"
    mkdir -p ~/.lima/_config
    printf "useHostResolver: false\ndns:\n- 8.8.8.8" > ~/.lima/_config/override.yaml

    if [[ "$COLIMA_STATUS" == *"$SUB"* ]]; then
      echo "restarting colima"
      colima start
    fi
  fi
fi



DOCKER_IMAGE="quay.io/cloudnativetoolkit/cli-tools-ibmcloud:v1.2-v0.4.23"



SUFFIX=$(echo $(basename ${SCRIPT_DIR}) | base64 | sed -E "s/[^a-zA-Z0-9_.-]//g" | sed -E "s/.*(.{5})/\1/g")
CONTAINER_NAME="cli-tools-${SUFFIX}"

echo "Cleaning up old container: ${CONTAINER_NAME}"

${DOCKER_CMD} kill ${CONTAINER_NAME} 1> /dev/null 2> /dev/null
${DOCKER_CMD} rm ${CONTAINER_NAME} 1> /dev/null 2> /dev/null

ARG_ARRAY=( "$@" )

if [[ " ${ARG_ARRAY[*]} " =~ " --pull " ]]; then
  echo "Pulling container image: ${DOCKER_IMAGE}"
  ${DOCKER_CMD} pull "${DOCKER_IMAGE}"
fi


ENV_VARS=""
if [[ -f "credentials.properties" ]]; then
  echo "parsing credentials.properties..."
  props=$(grep -v '^#' credentials.properties)
  while read line ; do
    #remove export statement prefixes
    CLEAN="$(echo $line | sed 's/export //' )"

    #parse key-value pairs
    IFS=' =' read -r KEY VALUE <<< ${CLEAN//\"/ }

    # don't add an empty key
    if [[ -n "${KEY}" ]]; then
      ENV_VARS="-e $KEY=$VALUE $ENV_VARS"
    fi
  done <<< "$props"
fi


echo "Initializing container ${CONTAINER_NAME} from ${DOCKER_IMAGE}"
${DOCKER_CMD} run -itd --name ${CONTAINER_NAME} \
   --device /dev/net/tun --cap-add=NET_ADMIN \
   -v "${SRC_DIR}:/terraform" \
   -v "workspace-${AUTOMATION_BASE}-${UID}:/workspaces" \
   ${ENV_VARS} \
   -w /terraform \
   ${DOCKER_IMAGE}

echo "Attaching to running container..."
${DOCKER_CMD} attach ${CONTAINER_NAME}
