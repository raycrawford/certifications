# Deploying VM Workloads
* Focus on API and Portal for 532 and PS for 533.

## [Best practices referenced in Swiger's video](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/virtual-machines-windows/single-vm)
Here are a few FYI's from that reference architecture:
* VHD's and Diag logs go in separate LRS storage accounts within the Resource Group
* Reference Availability Sets to ensure up time
* Recommend DS and GS machines because they support premium storage
* Really pushes Premium Storage for IOPs & recommends Managed Storage (which isn't on this exam)
* Recommmends not storing stuff on OS disk but mentions that you can resize it using PowerShell post-deployment
* All NSGs contain a set of default rules, including a rule that blocks all inbound Internet traffic. The default rules cannot be deleted, but other rules can override them.
* Resource Groups are good for grouping things on the same ALM and for enabling easy cost roll up

## Deploying & Creating VMs (Slide 14)
### Marketplace
### PowerShell (need to understand that we can, but may not need to know HOW for this exam); here are the general steps:
* [Link from slide 14](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/tutorial-manage-vm)
* Create Resource Group
* Create VNet
  * Create Subnet config
  * Create Virtual Network
* Other Network config:
    * Create public IP address
    * Create a NIC on that subnet that also uses the Public IP
    * Create an NSG
    * Add the NSG to the Subnet
    * Update the Virtual network
* Create the VM
  * Create initial configuration of VM (size & name)
  * Set OS high-level details
  * Set OS image specifics
  * Add OS disk
  * Add previously created NIC to configs
  * Create the VM    

### ARM Templates (Need to understand details of this one)
* There is appparently an ARM Template portal in the portal...  that's news to me...
* [Link from slide 15](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-create-first-template)
* Deploying using PS

```
Login-AzureRmAccount

New-AzureRmResourceGroup -Name examplegroup -Location "South Central US"
New-AzureRmResourceGroupDeployment -ResourceGroupName examplegroup -TemplateFile azuredeploy.json
```    

* Deploying using CLI

```
az login

az group create --name examplegroup --location "South Central US"
az group deployment create --resource-group examplegroup --template-file azuredeploy.json
```
## Desired State Configuration is briefly mentioned on Slide 16 (~ 7 minutes in)
* [URL referenced on Slide 16](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/extensions-dsc-template)
* More or less, this is like a custom script extension...
* It's a resource for an ARM template
* DSC code has to be stored at a publically-accessible URL

## Uploading Images (Slide 17) ***This is something I should try since I've never done it***
* [URL from slide](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/upload-generalized-managed)
  * "SysPrep" VM
  * Upload it
    * `Add-AzureRmVhd -ResourceGroupName <> -Destination <> -LocalFilePath <>`
    * Or you can use AZCopy or similar tools to get the image to Azure
    * I think that Add-AzureRmVhd and Save-AzureRmVhd may just be specialized AZCopy thingies...
  * Provision it
    * Build your image object using the code below
    * Replace lines 52 - 57 of virtual_machines-create-powershell.ps1 with `$vm = Set-AzureRmVMSourceImage -VM $vm -Id $image.Id`      
```
$vmName = "myVM"
$computerName = "myComputer"
$vmSize = "Standard_DS1_v2"
$location = "East US" 
$imageName = "yourImageName"
$imageConfig = New-AzureRmImageConfig -Location $location
$imageConfig = Set-AzureRmImageOsDisk -Image $imageConfig -OsType Windows -OsState Generalized -BlobUri $urlOfUploadedImageVhd
$image = New-AzureRmImage -ImageName $imageName -ResourceGroupName $rgName -Image $imageConfig
```

## Availability sets
* [Manage the availablity of VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/manage-availability)
* [How to create availability sets](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/tutorial-availability-sets)
* 5 Upgrade domains by default
* 3 Fault domains by default

# Monitoring
* look into app insights
* Not really covered in Brian Swiger's video

# Configuration Management
* Discussed DCS extension, but not in great depth

# Networking
* Not really covered in Brian Swiger's video
* Probably not on the exam, but interesting: load balancer probe comes from 168.63.129.16.  This is allowed in default NSGs, but make sure you don't override it.
* Azure reserves 5 IP addresses of every subnet...  I wonder what for

# Scaling
* Not really covered in Brian Swiger's video
* Storage when using Scale Sets
  * Recommend managed storage
  * If not managed storage:
    * no more than 20 VMs per storage account with overprovisioning enabled
    * no more that 40 VMs per storage account with overprovisioning disabled
* Two basic ways to configure VMs deployed in a scale set:
  1. Use extensions like Chef, but it will take longer to deploy
  1. Use a VHD on a managed disk; quicker, but you have to keep the image up to date

# Storage
## Replication options
* LRS: 3 copies in same facilities
* ZRS: 3 copies of data in 2-3 facilities within a single region
* GRS: LRS in 2 different regions 100's of miles apart
* ROGRS: GRS, but can be read in 2nd region
  * append -secondary to the SA part of the storage URL

## Disk Caching

## Storage capacity
* [Scalability & Performance Targets](https://docs.microsoft.com/en-us/azure/storage/storage-scalability-targets)
* Sizing and egress traffic limits

## Azure File Service
* File system I/O APIs

## Premium vs Standard
* [SA URL](https://docs.microsoft.com/en-us/azure/storage/storage-create-storage-account)
* [Premium URL](https://docs.microsoft.com/en-us/azure/storage/storage-premium-storage)

# VM Networking
* NSG (Network Security Groups)
  * Applied to a NIC or subnet
  * Look into diagnostic logging
* UDRs (User Defined Routes) ***(NEED TO UNDERSTAND BETTER)***
  * [Link to UDR docs](aka.ms/Azure/UDR)
  * specify next hop to a subnet
  * Force tunneling to Internet via your on-premise network
  * Use of virtual appliances in your Azure environment
* Application Gateways
  * Websocket traffic
  * Sticky session apps
  * SSL offloading
  * It's a level 7 LB whereas ELB's and ILB's are level 4

# Virtual Machine Scale Sets
* PaaS like autoscale
* Identical VMs
* Can it only be used with scale sets?
* Is it a characteristic of a VM resource?

Stopped at 18 Minutes at the end of the VM section.
https://mva.microsoft.com/en-US/training-courses/certification-exam-overview-70532-developing-microsoft-azure-solutions-17404?l=YmdM8DmjD_506218965
