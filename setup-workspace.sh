#!/bin/bash

mkdir -p workspace
find . -type d -maxdepth 1 | grep -vE "[.]/[.].*" | grep -v workspace | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.]/(.*)~\1~g")

  echo "Setting up workspace/${name} from ${name}"

  mkdir -p "workspace/${name}"
  cd "workspace/${name}"
  ln -s "../../${name}/terraform/"* .
  ln -s ../../terraform.tfvars ./terraform.tfvars
  ln -s ../../ssh-* .
  cd - > /dev/null
done
