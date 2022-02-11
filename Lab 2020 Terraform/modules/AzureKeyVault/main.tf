data "azurerm_key_vault_secret" "DomainJoinCredentials" {
name = var.KeyVault.DomainJoin
key_vault_id = var.KeyVault.id
}

data "azurerm_key_vault_secret" "LocalAdministrator" {
name = var.KeyVault.LocalAdministrator
key_vault_id = var.KeyVault.id
}
output "LocalAdministratorPassword" {
  value = data.azurerm_key_vault_secret.LocalAdministrator.value
}
output "DomainJoinPassword" {
  value = data.azurerm_key_vault_secret.DomainJoinCredentials.value
}

output "DomainJoinUser" {
  value = var.KeyVault.DomainJoin  #.LocalAdministrator.value
}

output "LocalAdministratorUser" {
  value = var.KeyVault.LocalAdministrator  #.LocalAdministrator.value
}
