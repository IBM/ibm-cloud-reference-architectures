#!/usr/bin/env bash

find . -type d -maxdepth 1 | grep -vE "[.]/[.].*" | grep -vE "^[.]$" | grep -v workspace | sort -r | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.]/(.*)~\1~g")

  if [[ ! -f "./${name}/terraform.tfstate" ]]; then
    echo "*** No state found for ${name}. Skipping ***"
    continue
  fi

  echo "*** Destroying ${name} ***"

  cd "${name}" && \
    terraform init && \
    ./destroy.sh && \
    cd - 1> /dev/null || \
    exit 1
done
