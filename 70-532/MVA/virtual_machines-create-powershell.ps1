New-AzureRmResourceGroup -ResourceGroupName myResourceGroupVM -Location EastUS
$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig `
-Name mySubnet `
-AddressPrefix 192.168.1.0/24
$vnet = New-AzureRmVirtualNetwork `
-ResourceGroupName myResourceGroupVM `
-Location EastUS `
-Name myVnet `
-AddressPrefix 192.168.0.0/16 ` 
-Subnet $subnetConfig
$pip = New-AzureRmPublicIpAddress ` 
-ResourceGroupName myResourceGroupVM `
-Location EastUS ` 
-AllocationMethod Static `
-Name myPublicIPAddress
$nic = New-AzureRmNetworkInterface `
-ResourceGroupName myResourceGroupVM  `
-Location EastUS `
-Name myNic `
-SubnetId $vnet.Subnets[0].Id `
-PublicIpAddressId $pip.Id
$nsgRule = New-AzureRmNetworkSecurityRuleConfig `
-Name myNSGRule `
-Protocol Tcp `
-Direction Inbound `
-Priority 1000 `
-SourceAddressPrefix * `
-SourcePortRange * `
-DestinationAddressPrefix * `
-DestinationPortRange 3389 `
-Access Allow
$nsg = New-AzureRmNetworkSecurityGroup `
-ResourceGroupName myResourceGroupVM `
-Location EastUS `
-Name myNetworkSecurityGroup `
-SecurityRules $nsgRule
Set-AzureRmVirtualNetworkSubnetConfig `
-Name mySubnet `
-VirtualNetwork $vnet `
-NetworkSecurityGroup $nsg `
-AddressPrefix 192.168.1.0/24
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
# Create VM
$cred = Get-Credential
$vm = New-AzureRmVMConfig -VMName myVM -VMSize Standard_D1
$vm = Set-AzureRmVMOperatingSystem `
-VM $vm `
-Windows `
-ComputerName myVM `
-Credential $cred `
-ProvisionVMAgent -EnableAutoUpdate
$vm = Set-AzureRmVMSourceImage `
-VM $vm `
-PublisherName MicrosoftWindowsServer `
-Offer WindowsServer `
-Skus 2016-Datacenter `
-Version latest
$vm = Set-AzureRmVMOSDisk `
-VM $vm `
-Name myOsDisk `
-DiskSizeInGB 128 `
-CreateOption FromImage `
-Caching ReadWrite
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
New-AzureRmVM -ResourceGroupName myResourceGroupVM -Location EastUS -VM $vm
