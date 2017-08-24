azure vm sizes --location <location>
azure vm deallocate <resource-group> <vm-name>

# Create a NIC
```
npm install --global azure-cli
azure config mode arm
azure login
azure group create --name "CLIExample" --location "East US 2"
azure network vnet create -g "CLIGroup" -n "TestNVET" -l "East US 2"
azure network vnet subnet create -g "CLIGroup" --vnet-name "Test-VNET" -n "Apps" --address-prefix 10.0.1.0/24
azure network nic create -g "CLIGroup" -l "East US 2" -n "TestNIC" --subnet-name "Apps" --subnet-vnet-name "TestVNET"
```

```
azure provider register -n Microsoft.Web
azure group create --name "AZ-RG-Test_Web_App" --location "East US 2"
azure resource create --name "WebAppPlan" --resource-group "AZ-RG-Test_Web_App" --resource-type "Microsoft.Web/Sites" --api-version "2014-06-01" --json
azure resource show --name "WebAppPlan" --resource-type "Microsoft.Web/Sites" --resource-group "AZ-RG-Test_Web_App" --api-version "2014-06-01" --json
azure resource delete --name "WebAppPlan" --resource-type "Microsoft.Web/Sites" --resource-group "AZ-RG-Test_Web_App" --api-version "2014-06-01" --json --quiet
```