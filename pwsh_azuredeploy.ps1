$resourceGroupName="from-market-testing"
$subscriptionId="My Azure Subscription"
$resourceGroupLocation="West Europe"

$templateFile="template.json"

# Marketplace offer details
$publisher="xyzrd-group-ou"
$offer="c73-zultys-mxvirtual"
$sku="c73-14-0-4"
$version="latest"

# sign in
Write-Host "Logging in...";
Login-AzureRmAccount;

# select subscription
Write-Host "Selecting subscription '$subscriptionId'";
Select-AzureRmSubscription -SubscriptionID $subscriptionId;

# Accept terms
$terms = Get-AzureRmMarketplaceTerms -Publisher $publisher -Product $offer -Name $sku
if (!$terms.Accepted) {
    $terms | Set-AzureRmMarketplaceTerms -Accept
}

#Create or check for existing resource group
$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if(!$resourceGroup)
{
    Write-Host "Resource group '$resourceGroupName' does not exist.";
    Write-Host "Creating resource group '$resourceGroupName' in location '$resourceGroupLocation'";
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation
}
else{
    Write-Host "Using existing resource group '$resourceGroupName'";
}


New-AzureRmResourceGroupDeployment -Name "MXV-deployment" -ResourceGroupName $resourceGroupName -TemplateFile $templateFile `
                                    -location $resourceGroupLocation -publisher $publisher -offer $offer -sku $sku -version $version
