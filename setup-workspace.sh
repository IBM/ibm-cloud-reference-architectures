#!/bin/bash

mkdir -p workspace
cd workspace

../create-ssh-keys.sh
cp ../terraform.tfvars .

find .. -type d -maxdepth 1 | grep -vE "[.][.]/[.].*" | grep -v workspace | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.][.]/(.*)~\1~g")

  if [[ ! -d "../${name}/terraform" ]]; then
    continue
  fi

  echo "Setting up workspace/${name} from ${name}"

  mkdir -p "${name}"
  cd "${name}"

  cp -R "../../${name}/terraform/"* .
  ln -s ../terraform.tfvars ./terraform.tfvars
  ln -s ../../destroy.sh ./destroy.sh
  ln -s ../ssh-* .
  cd - > /dev/null
done
