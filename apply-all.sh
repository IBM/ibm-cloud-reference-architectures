#!/usr/bin/env bash

find . -type d -maxdepth 1 | grep -vE "[.]/[.].*" | grep -vE "^[.]$" | grep -v workspace | sort | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.]/(.*)~\1~g")

  echo "*** Applying ${name} ***"

  cd "${name}" && \
    terraform init && \
    terraform apply -auto-approve && \
    cd - 1> /dev/null || \
    exit 1
done
