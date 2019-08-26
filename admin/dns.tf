resource "azurerm_resource_group" "master" {
  name     = var.azure_resource_group
  location = var.azure_location

  tags = {
    environment = "workshop"
    workshop    = "ace"
  }
}

resource "azurerm_dns_zone" "master" {
  name                = "workshop-2019.ace.evry.services"
  resource_group_name = "${azurerm_resource_group.master.name}"

  tags = {
    environment = "workshop"
    workshop    = "ace"
  }
}

output "dns_name_servers" {
  value = azurerm_dns_zone.master.name_servers
}
