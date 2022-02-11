output "TimeStamp" {
  description = "Finishtime and Creationtime of New resources."
  value = formatdate("YYYY-MM-DD hh:mm", timestamp())
}
output "PrivateIPaddress" {
  value = azurerm_network_interface.VMInterface.private_ip_address
}
output "UserNameVM" {
  value = azurerm_windows_virtual_machine.VM-obj.admin_username
}




