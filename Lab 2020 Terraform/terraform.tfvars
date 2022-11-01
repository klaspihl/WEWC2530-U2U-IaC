subscriptionID = "a5a78344-f887-4c4e-aeed-8226f6a5c1e4"
location = "northeurope" #"eastus" #West Europe
system = "TerraLab"
ServerName = "pihl-lab"
Server = {
    vm_size="Standard_B2s"
    publisher="MicrosoftWindowsServer"
    offer="WindowsServer"
    sku="2019-Datacenter"
    version="latest"
    ShutDown = "23:00"
    OSAdministratorName = "vmadmin"
}
ImportedResources = {
    ResourceGroup = "Lab"
    VNET = "klpih-lab-vnet"
    VNETResourceGroup = "klpih-lab"
    Subnet = "lab"
}