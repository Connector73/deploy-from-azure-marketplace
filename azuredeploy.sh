#!/bin/bash

# login to customer account
az login

LOCATION="WestEurope"
RESGROUPNAME="from-market-resgroup"

# Select subscription name
SUBSCRIPTION="Production"

az account set -s $SUBSCRIPTION

# create resource group
echo "Creating resource group..."
az group create -l $LOCATION -n "$RESGROUPNAME"


# deploy VM
echo "Start deployment..."
startime=`date +%H:%M:%S`

az group deployment create \
    --name "MXV-deployment" \
    --resource-group $RESGROUPNAME \
    --template-file template.json \
    --parameters \
                location=$LOCATION 

echo "Finish deployment..." 
echo $startime"---"`date +%H:%M:%S`

