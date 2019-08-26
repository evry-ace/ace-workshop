resource "azurerm_resource_group" "ws" {
  count = length(var.users)

  name     = "${var.prefix}-${var.users[count.index].id}"
  location = var.azure_location

  tags = {
    environment = "workshop"
    workshop    = "ace"
    owner       = var.users[count.index].id
  }
}

resource "azurerm_public_ip" "ws" {
  count = length(var.users)

  name     = "aksIngressPublicIp"
  location = var.azure_location

  resource_group_name = azurerm_resource_group.ws[count.index].name
  allocation_method   = "Static"

  tags = {
    environment = "workshop"
    workshop    = "ace"
    owner       = var.users[count.index].id
  }
}

resource "azurerm_dns_a_record" "ws" {
  count = length(var.users)

  name                = "*.${var.users[count.index].id}"
  zone_name           = azurerm_dns_zone.master.name
  resource_group_name = azurerm_dns_zone.master.resource_group_name
  ttl                 = 60
  records             = [azurerm_public_ip.ws[count.index].ip_address]
}

resource "random_string" "storage_id" {
  count = length(var.users)

  length  = 4
  upper   = false
  special = false
}

resource "azurerm_storage_account" "ws" {
  count = length(var.users)

  name                     = substr("${replace(var.prefix, "-", "")}${var.users[count.index].id}${random_string.storage_id[count.index].result}", 0, 24)
  resource_group_name      = azurerm_resource_group.ws[count.index].name
  location                 = var.azure_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "workshop"
    workshop    = "ace"
    owner       = var.users[count.index].id
  }
}

resource "azurerm_storage_container" "ws" {
  count = length(var.users)

  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.ws[count.index].name
  container_access_type = "private"
}
