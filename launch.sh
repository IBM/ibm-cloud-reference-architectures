#!/bin/bash

# IBM GSI Ecosystem Lab

SCRIPT_DIR="$(cd $(dirname "$0"); pwd -P)"
SRC_DIR="${SCRIPT_DIR}/automation"

AUTOMATION_BASE=$(basename "${SCRIPT_DIR}")

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

DOCKER_IMAGE="quay.io/cloudnativetoolkit/cli-tools:v1.1-v1.8.1"

SUFFIX=$(echo $(basename ${SCRIPT_DIR}) | base64 | sed -E "s/[^a-zA-Z0-9_.-]//g" | sed -E "s/.*(.{5})/\1/g")
CONTAINER_NAME="cli-tools-${SUFFIX}"

echo "Cleaning up old container: ${CONTAINER_NAME}"

DOCKER_CMD="docker"
${DOCKER_CMD} kill ${CONTAINER_NAME} 1> /dev/null 2> /dev/null
${DOCKER_CMD} rm ${CONTAINER_NAME} 1> /dev/null 2> /dev/null

if [[ -n "$1" ]]; then
    echo "Pulling container image: ${DOCKER_IMAGE}"
    ${DOCKER_CMD} pull "${DOCKER_IMAGE}"
fi

ENV_FILE=""
if [[ -f "credentials.properties" ]]; then
  ENV_FILE="--env-file credentials.properties"
fi

echo "Initializing container ${CONTAINER_NAME} from ${DOCKER_IMAGE}"
${DOCKER_CMD} run -itd --name ${CONTAINER_NAME} \
   -v "${SRC_DIR}:/terraform" \
   -v "workspace-${AUTOMATION_BASE}:/workspaces" \
   ${ENV_FILE} \
   -w /terraform \
   ${DOCKER_IMAGE}

echo "Attaching to running container..."
${DOCKER_CMD} attach ${CONTAINER_NAME}
