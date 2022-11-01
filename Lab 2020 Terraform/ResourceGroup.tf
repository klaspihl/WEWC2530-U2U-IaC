resource "azurerm_resource_group" "ResourceGroup" {
  name     = "RG-${var.system}"
  location = var.location
tags = var.default_tags
  #tags = merge(
  #    var.default_tags,
  #    tomap(
  #      "StartDate", formatdate("YYYY-MM-DD hh:mm", timestamp())
  #      )
  #    )
  #  lifecycle {
  #    ignore_changes = [
  #      tags["StartDate"]
  #    ]
  #  }

}
