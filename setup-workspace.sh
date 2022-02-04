#!/bin/bash

TEMPLATE_FLAVOR=""
REF_ARCH=""

Usage()
{
   echo "Creates a workspace folder and populates it with architectures."
   echo
   echo "Usage: setup-workspace.sh -t TEMPLATE_FLAVOR -a REF_ARCH"
   echo "  options:"
   echo "  t     the template to use for the deployment (small or full)"
   echo "  a     the reference architecture to deploy (vpc or ocp or all)"
   echo "  h     Print this help"
   echo
}

# Get the options
while getopts ":a:t:" option; do
   case $option in
      h) # display Help
         Usage
         exit 1;;
      t) # Enter a name
         TEMPLATE_FLAVOR=$OPTARG;;
      a) # Enter a name
         REF_ARCH=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Usage
         exit 1;;
   esac
done

if [[ -z "${TEMPLATE_FLAVOR}" ]] || [[ ! "${TEMPLATE_FLAVOR}" =~ small|full ]] || [[ -z "${REF_ARCH}" ]] || [[ ! "${REF_ARCH}" =~ ocp|vpc|all ]]; then
  Usage
  exit 1
fi

mkdir -p workspace
cd workspace

echo "Setting up workspace from '${TEMPLATE_FLAVOR}' template"
echo "*****"

../create-ssh-keys.sh
cp "../terraform.tfvars.template-${TEMPLATE_FLAVOR}" ./terraform.tfvars

# append random string into suffix variable in tfvars  to prevent name collisions in object storage buckets
if command -v openssl &> /dev/null
then
    printf "\n\nsuffix=\"$(openssl rand -hex 4)\"\n" >> ./terraform.tfvars
fi


cp ../apply-all.sh ./apply-all.sh
cp ../destroy-all.sh ./destroy-all.sh

VPC_ARCH="000|100|110|120|140"
OCP_ARCH="000|100|110|130|150|160|165"

find .. -type d -maxdepth 1 | grep -vE "[.][.]/[.].*" | grep -v workspace | sort | \
  while read dir;
do
  name=$(echo "$dir" | sed -E "s~[.][.]/(.*)~\1~g")

  if [[ ! -d "../${name}/terraform" ]]; then
    continue
  fi

  if [[ "${REF_ARCH}" == "ocp" ]] && [[ ! "${name}" =~ ${OCP_ARCH} ]]; then
    continue
  fi

  if [[ "${REF_ARCH}" == "vpc" ]] && [[ ! "${name}" =~ ${VPC_ARCH} ]]; then
    continue
  fi

  if [[ "${REF_ARCH}" == "all" ]] && [[ ! "${name}" =~ ${VPC_ARCH}|${OCP_ARCH} ]]; then
    continue
  fi

  echo "Setting up workspace/${name} from ${name}"

  mkdir -p "${name}"
  cd "${name}"

  cp -R "../../${name}/terraform/"* .
  ln -s ../terraform.tfvars ./terraform.tfvars
  ln -s ../../apply.sh ./apply.sh
  ln -s ../../destroy.sh ./destroy.sh
  ln -s ../ssh-* .
  cd - > /dev/null
done
