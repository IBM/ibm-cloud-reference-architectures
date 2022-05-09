#! /bin/bash

CATALOG_NAME=$1
OFFERING_NAME=$2
ASSET_URL=$3
VERSION=$4
RESOURCE_GROUP=$5
EXAMPLE=$6

echo "$OFFERING_NAME : onboard version, validate, publish"

# import the offering into the catalog
if [ -z ${EXAMPLE+x} ]; then
    ibmcloud catalog offering import-version --zipurl "$ASSET_URL" --target-version "$VERSION" --catalog "$CATALOG_NAME" --offering "$OFFERING_NAME" --include-config --example "$EXAMPLE" --schematics-destroy
    cp "examples/${EXAMPLE}/values.tfvars" valid-values.tfvars
else
    ibmcloud catalog offering import-version --zipurl "$ASSET_URL" --target-version "$VERSION" --catalog "$CATALOG_NAME" --offering "$OFFERING_NAME" --include-config
fi

# get the catalog's version locator for the version just uploaded
ibmcloud catalog offering get --catalog "$CATALOG_NAME" --offering "$OFFERING_NAME" --output json > offering.json
versionLocator=$(jq -r --arg version $VERSION '.kinds[] | select(.format_kind=="terraform").versions[] | select(.version==$version).version_locator' < offering.json)
echo "version locator: $versionLocator"

# need to target a resource group
ibmcloud target -g "$RESOURCE_GROUP"

# update the version in the catalog and specify a minimum version of terraform for runtime.  This is temporary.  Schematics is 
# providing a fix that will scan and determine the minimum version based on the tf files.
./scripts/set_minimum_tf_version.sh "$CATALOG_NAME" "$OFFERING_NAME" "$VERSION"

# dump the validation values into the log
cat valid-values.json | jq

# run validation for the terraform with the provided values from above - timeout is 1 hour. 
if [ -z ${EXAMPLE+x} ]; then
    ibmcloud catalog offering version validate --vl "$versionLocator" --override-values valid-values.tfvars --timeout 5400
else
    ibmcloud catalog offering version validate --vl "$versionLocator" --override-values valid-values.json --timeout 5400
fi

if [[ $? -eq 0 ]]
then
    # mark the version as 'ready' in the catalog.
    ibmcloud catalog offering ready --vl "$versionLocator"

    # mark the version as published at the account level in the catalog.
    ibmcloud catalog offering publish account --catalog "$CATALOG_NAME" --offering "$OFFERING_NAME"
else
    echo "Validation failed.  Version is in draft status in the catalog."
fi
