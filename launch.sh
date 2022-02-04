#!/usr/bin/env bash

ENV="credentials"

function prop {
    grep "${1}" ${ENV}.properties | grep -vE "^#" | cut -d'=' -f2 | sed 's/"//g'
}

if [[ -f "${ENV}.properties" ]]; then
    # Load the credentials
    IBMCLOUD_API_KEY=$(prop 'ibmcloud.api.key')
    CLASSIC_API_KEY=$(prop 'classic.api.key')
    CLASSIC_USERNAME=$(prop 'classic.username')
    LOGIN_USER=$(prop 'login.user')
    LOGIN_PASSWORD=$(prop 'login.password')
    LOGIN_TOKEN=$(prop 'login.token')
    SERVER_URL=$(prop 'server.url')
else
    helpFunction "The ${ENV}.properties file is not found."
fi


docker run -it \
  -e "TF_VAR_ibmcloud_api_key=${IBMCLOUD_API_KEY}" \
  -e "IBMCLOUD_API_KEY=${IBMCLOUD_API_KEY}" \
  -v ${PWD}:/terraform \
  -w /terraform/workspace \
  quay.io/ibmgaragecloud/cli-tools:v0.15
