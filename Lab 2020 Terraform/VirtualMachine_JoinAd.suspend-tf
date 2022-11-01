resource "azurerm_virtual_machine_extension" "JoinAD" {
  name                 = "JoinAD"
  virtual_machine_id   = azurerm_windows_virtual_machine.VM-obj.id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  # What the settings means: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain

  settings           = <<SETTINGS
        {
            "Name": "pihl.local",
            "OUPath": "OU=Computers,OU=LAB,DC=pihl,DC=local",
            "User": "pihl\\sk_DomainJoin",
            "Restart": "true",
            "Options": "3"
        }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password":  "${module.AzureKeyVault.DomainJoinPassword}"
    }
  PROTECTED_SETTINGS
  depends_on         = [azurerm_windows_virtual_machine.VM-obj]
}

# Disable local user
#Disable-LocalUser -name var.Server.OSAdministratorName -confirm:0

resource "azurerm_virtual_machine_extension" "DisableLocalAdministrator" {
  name                 = "DisableLocalAdministrator"
  #location  = azurerm_windows_virtual_machine.VM-obj.location
  #resource_group_name = azurerm_windows_virtual_machine.VM-obj.resource_group_name
  #virtual_machine_name = azurerm_windows_virtual_machine.VM-obj.name
  virtual_machine_id   = azurerm_windows_virtual_machine.VM-obj.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
        "commandToExecute":"powershell.exe -Command Disable-LocalUser -name ${module.AzureKeyVault.LocalAdministratorUser} -confirm:0;exit 0"
    }
SETTINGS
}