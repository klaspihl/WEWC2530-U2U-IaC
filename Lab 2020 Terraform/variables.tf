variable "subscriptionID" {
  type        = string
  description = "Variable for our resource group"
}

variable "system" {
  type        = string
  description = "Name of the system or environment"
}


variable "location" {
  type        = string
  description = "location of your resource group"
  default     = "westeurope"
}

variable "ServerName" {
  type        = string
  description = "Server logical name"

}


variable "default_tags" {
  description = "Default tags for resource"
  type        = map
  default = {
    CostCenter : "Private",
    BusinessUnit : "Pihl",
    Env : "Dev",
    Owner : "Klas.Pihl@Atea.se"
    Maintainer : "Terraform"
  }
}

variable "Server" {
  description = "Collected variables around Virtual machine"
  type = object({
    vm_size   = string
    publisher = string
    offer     = string
    sku       = string
    version   = string
    ShutDown = string
    OSAdministratorName =string
  })

}

variable "ImportedResources" {
  description = "Resources not managed by Terraform"
  type = object({
    ResourceGroup = string
    VNET          = string
    VNETResourceGroup = string
    Subnet        = string
  })
}

