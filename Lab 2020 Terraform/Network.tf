
resource "azurerm_network_security_group" "net-SG-obj" {
  name                = "NSG-${var.system}"
  location            = var.location
  resource_group_name = azurerm_resource_group.ResourceGroup.name
  tags = merge(
    var.default_tags,
    tomap({
      "StartDate"= formatdate("YYYY-MM-DD hh:mm", timestamp())
})
  )

  lifecycle {
    ignore_changes = [
      tags["StartDate"]
    ]
  }
}

resource "azurerm_network_security_rule" "Port3389" {
  name                        = "AllowRDP"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_network_security_group.net-SG-obj.resource_group_name
  network_security_group_name = azurerm_network_security_group.net-SG-obj.name

}
data "azurerm_virtual_network" "vnet-obj" {
  name                = var.ImportedResources.VNET
  resource_group_name = var.ImportedResources.VNETResourceGroup
}
/*
resource "azurerm_virtual_network" "vnet-obj" {
  name                = "VNET-${var.system}"
  location            = var.location
  resource_group_name = azurerm_resource_group.ResourceGroup.name
  address_space       = ["10.1.0.0/16"]
  dns_servers         = ["1.1.1.1", "10.254.0.253"]

  tags = merge(
      var.default_tags,
      map(
        "StartDate", formatdate("YYYY-MM-DD hh:mm", timestamp())
        )
      )
    lifecycle {
      ignore_changes = [
        tags["StartDate"]
      ]
    }
}
*/
data "azurerm_subnet" "net-sub-obj" {
  name                 = var.ImportedResources.Subnet
  virtual_network_name = data.azurerm_virtual_network.vnet-obj.name
  resource_group_name  = var.ImportedResources.VNETResourceGroup
}

/*
resource "azurerm_subnet" "net-sub-obj" {
  name                 = "SNET-testsubnet"
  resource_group_name  = azurerm_network_security_group.net-SG-obj.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet-obj.name
  address_prefix = "10.1.1.0/24"
}
*/
/*
resource "azurerm_public_ip" "cloudskills-publicIP" {
  name                = "cloudskills-publicIP"
  location            = "eastus"
  resource_group_name = azurerm_network_security_group.net-SG-obj.resource_group_name
  allocation_method   = "Static"
  ip_version          = "IPv4"

  tags = {
    environment = "Dev"
  }
}
*/
resource "azurerm_network_interface" "VMInterface" {
  name                = substr("NIC-VM-${var.ServerName}", 0, 79)
  location            = azurerm_network_security_group.net-SG-obj.location
  resource_group_name = azurerm_network_security_group.net-SG-obj.resource_group_name

  ip_configuration {
    name                          = "DevConfig1"
    subnet_id                     = data.azurerm_subnet.net-sub-obj.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.cloudskills-publicIP.id
  }

  tags = merge(
    var.default_tags,
    tomap(
      {"StartDate"= formatdate("YYYY-MM-DD hh:mm", timestamp())}
    )
  )
  lifecycle {
    ignore_changes = [
      tags["StartDate"]
    ]
  }
}
