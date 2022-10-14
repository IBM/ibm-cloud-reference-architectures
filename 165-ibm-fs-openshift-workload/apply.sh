#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)

VARIABLES_FILE="${1}"
if [[ -z "${VARIABLES_FILE}" ]]; then
  VARIABLES_FILE="${SCRIPT_DIR}/variables.yaml"
fi

YQ=$(command -v yq4 || command -v yq)
if [[ -z "${YQ}" ]] || [[ $(${YQ} --version | sed -E "s/.*version ([34]).*/\1/g") == "3" ]]; then
  echo "yq v4 is required"
  exit 1
fi

if [[ -f "${SCRIPT_DIR}/terraform/terraform.tfvars" ]]; then
  cp "${SCRIPT_DIR}/terraform/terraform.tfvars" "${SCRIPT_DIR}/terraform/terraform.tfvars.backup"
  rm "${SCRIPT_DIR}/terraform/terraform.tfvars"
fi

if [[ ! -f "${VARIABLES_FILE}" ]]; then
  echo "Variables can be provided in a yaml file passed as the first argument"
  echo ""
fi

TMP_VARIABLES_FILE="${VARIABLES_FILE}.tmp"

echo "variables: []" > ${TMP_VARIABLES_FILE}

cat "${SCRIPT_DIR}/bom.yaml" | ${YQ} e '.spec.variables[] | .name' - | while read name; do
  default_value=$(cat "${SCRIPT_DIR}/bom.yaml" | NAME="${name}" ${YQ} e '.spec.variables[] | select(.name == env(NAME)) | .defaultValue // ""' -)
  sensitive=$(cat "${SCRIPT_DIR}/bom.yaml" | NAME="${name}" ${YQ} e '.spec.variables[] | select(.name == env(NAME)) | .sensitive // false' -)
  description=$(cat "${SCRIPT_DIR}/bom.yaml" | NAME="${name}" ${YQ} e '.spec.variables[] | select(.name == env(NAME)) | .description // ""' -)

  variable_name="TF_VAR_${name}"

  environment_variable=$(env | grep "${variable_name}" | sed -E 's/.*=(.*).*/\1/g')
  value="${environment_variable}"
  if [[ -f "${VARIABLES_FILE}" ]]; then
    value=$(cat "${VARIABLES_FILE}" | NAME="${name}" ${YQ} e '.variables[] | select(.name == env(NAME)) | .value // ""' -)
    if [[ -z "${value}" ]]; then
      value="${environment_variable}"
    fi
  fi

  while [[ -z "${value}" ]]; do
    echo "Provide a value for '${name}':"
    if [[ -n "${description}" ]]; then
      echo "  ${description}"
    fi
    sensitive_flag=""
    if [[ "${sensitive}" == "true" ]]; then
      sensitive_flag="-s"
    fi
    default_prompt=""
    if [[ -n "${default_value}" ]]; then
      default_prompt="(${default_value}) "
    fi
    read -u 1 ${sensitive_flag} -p "> ${default_prompt}" value
    value=${value:-$default_value}
  done

  echo "${name} = \"${value}\"" >> "${SCRIPT_DIR}/terraform/terraform.tfvars"
  if [[ "${sensitive}" != "true" ]]; then
    NAME="${name}" VALUE="${value}" ${YQ} e -i -P '.variables += [{"name": env(NAME), "value": env(VALUE)}]' "${TMP_VARIABLES_FILE}"
  fi
done

cp "${TMP_VARIABLES_FILE}" "${VARIABLES_FILE}"
rm "${TMP_VARIABLES_FILE}"

cd ${SCRIPT_DIR}/terraform
terraform init
terraform apply
