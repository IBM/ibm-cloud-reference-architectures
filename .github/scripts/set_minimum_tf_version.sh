#! /bin/bash

TERRAFORM_MIN_VERSION="0.15"
CATALOG=$1
OFFERING=$2
VERSION=$3

echo "edit json to add minimumVersion from previous version to new version"
jq --arg version "$VERSION" --arg minVersion "$TERRAFORM_MIN_VERSION" '.kinds[] | select(.format_kind=="terraform").versions[] | select(.version==$version) += {"required_resources":[{"type":"terraformVersion","value": $minVersion}]} ' <offering.json > versions.json
jq --slurpfile values versions.json '.kinds[] | select(.format_kind=="terraform").versions = $values' <offering.json > kinds.json
jq --slurpfile values kinds.json '.kinds = $values' <offering.json > updatedoffering.json

echo "update offering with patched json"
ibmcloud catalog offering update -c "$CATALOG" -o "$OFFERING" --updated-offering updatedoffering.json