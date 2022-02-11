subscriptionID = "8332bda4-0051-4602-9ab3-42fae7294d3d"
location = "westeurope" #"eastus" #West Europe
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
    VNET = "pihl-privat-vpn"
    VNETResourceGroup = "pihl-privat"
    Subnet = "lab"
}