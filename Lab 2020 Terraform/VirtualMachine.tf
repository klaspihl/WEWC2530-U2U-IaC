resource "random_string" "PasswordString" {
  length      = 8
  special     = false
  number      = true
  min_numeric = 5
}



#https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html
resource "azurerm_windows_virtual_machine" "VM-obj" {
  name                = substr("VM-${var.ServerName}", 0, 14)
  resource_group_name = azurerm_resource_group.ResourceGroup.name
  location            = var.location
  size                = var.Server.vm_size
  admin_username      = module.AzureKeyVault.LocalAdministratorUser
  admin_password      = module.AzureKeyVault.LocalAdministratorPassword
  provision_vm_agent  = true
  timezone            = "W. Europe Standard Time"
  network_interface_ids = [
    azurerm_network_interface.VMInterface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.Server.publisher
    offer     = var.Server.offer
    sku       = var.Server.sku
    version   = var.Server.version
  }

  tags = merge(
    var.default_tags,
    map(
      "StartDate", formatdate("YYYY-MM-DD hh:mm", timestamp()),
      "ShutDown", var.Server.ShutDown
    )
  )

  lifecycle {
    ignore_changes = [
      tags["StartDate"],
      tags["ShutDown"],
      tags["StartUp"],
      tags["StartDay"]
    ]
  }
}
