# Save-AzureResourceGroupGalleryTemplate
Downloads a template from the gallery
 
`Save-AzureResourceGroupGalleryTemplate -Identity Microsoft.WebSiteSQLDatabase.0.2.2-preview -Path D:\Azure\Templates`

# Install-Module AzureRM
Installs a bunch of ARM modules

# Creating a Web App from PowerShell
```
Login-AzureRmAccount
New-AzureRMResourceGroup -Name "PSGroup" -Location "East US 2"
New-AzureRMAppServicePlan -ResourcesGroupName "PSGroup" -Name "WebPlan" -Location "East US 2"
New-AzureRmWebApp -ResourceGroupName "PSGroup" -AppServicePlan "WebPlan" -Name "edxwebexample" -Location "East US 2"
$appDetails = Get-AzureRmWebApp -ResourceGroupName "PSGroup" -Name "edxwebexample"
explorer "http:/$($appDetails.HostNames[0])"
```
