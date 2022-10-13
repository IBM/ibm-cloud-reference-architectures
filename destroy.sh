#! /bin/bash

RESOURCE_FILTER="$1"

echo ""
echo "Listing current state"
terraform state list

if [[ -n "${RESOURCE_FILTER}" ]]; then
  echo ""
  echo "Collecting resources to destroy using filter: ${RESOURCE_FILTER}"
  RESOURCE_LIST=""
  while read -r resource; do
    echo "  Adding $resource to destroy targets"
    RESOURCE_LIST="$RESOURCE_LIST -target=$resource"
  done < <(terraform state list | grep -E "${RESOURCE_FILTER}")
else
  echo ""
  echo "Collecting resources to destroy"
  RESOURCE_LIST=""
  while read -r resource; do
    echo "  Adding $resource to destroy targets"
    RESOURCE_LIST="$RESOURCE_LIST -target=$resource"
  done < <(terraform state list)
fi

if [[ -n "$RESOURCE_LIST" ]]; then
  echo ""
  echo "Planning destroy"
  terraform plan -destroy ${RESOURCE_LIST} -out=destroy.plan

  echo ""
  echo "Destroying resources"
  terraform apply -auto-approve destroy.plan
else
  echo ""
  echo "Nothing to destroy!!"
fi

