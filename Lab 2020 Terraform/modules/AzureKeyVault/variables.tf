variable "PassowrdSource" {
  type        = string
  default     = "AKV"
}

variable "KeyVault" {
  description = "Azure key vault properties for Windows server deployments"
  type = object({
    DomainJoin   = string
    LocalAdministrator = string
    id     = string
  })
}
