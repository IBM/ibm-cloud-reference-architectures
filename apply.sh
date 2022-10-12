#!/usr/bin/env bash


PARALLELISM=6

TYPE=$(grep "deployment-type/gitops" ./bom.yaml | sed -E "s~[^:]+: [\"'](.*)[\"']~\1~g")

if [[ "${TYPE}" == "true" ]]; then
  PARALLELISM=3
  echo "***** Setting parallelism for gitops type deployment for step ${name} to ${PARALLELISM} *****"
fi

terragrunt init
terragrunt apply -parallelism=$PARALLELISM -auto-approve
