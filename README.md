# Description
Script to deploy MX-Virtual from Azure Marketplace.

# Usage
Change **subscription** in script files to correct name or ID.

Change **marketplace variables** in script files to correct offer and sku if needed.

Ignore username and password in template. They are useless but need for deployment.
#### AZCLI 2.0:
Before use need to accept terms by manually installing from portal or use powershell. Only need to do it once.  
Use `azuredeploy.sh`

#### Powershell:
Use `pwsh_azuredeploy.ps1`