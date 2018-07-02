#!/bin/bash

# login to customer account
az login

LOCATION="WestEurope"
RESGROUPNAME="from-market-resgroup"

# Marketplace offer details
PUBLISHER="xyzrd-group-ou"
OFFER="c73-zultys-mxvirtual"
SKU="c73-14-0-4"
VERSION="latest"

# Select subscription name
SUBSCRIPTION="Visual Studio Professional"

az account set -s "$SUBSCRIPTION"

# create resource group
echo "Creating resource group..."
az group create -l "$LOCATION" -n "$RESGROUPNAME"


# deploy VM
echo "Start deployment..."
startime=`date +%H:%M:%S`

az group deployment create \
    --name "MXV-deployment" \
    --resource-group "$RESGROUPNAME" \
    --template-file template.json \
    --parameters \
                location="$LOCATION" \
                publisher="$PUBLISHER" \
                offer="$OFFER" \
                sku="$SKU" \
                version="$VERSION" 

echo "Finish deployment..." 
echo $startime"---"`date +%H:%M:%S`

