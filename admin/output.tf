data "template_file" "ws" {
  count = length(var.users)

  template = "${file("${path.module}/output/template.tpl")}"
  vars = {
    azure_subscription_id = var.azure_subscription_id
    azure_tenant_id       = var.azure_tenant_id
    ws_resource_group     = azurerm_resource_group.ws[count.index].name
    azure_location        = var.azure_location
    ws_sp_client_id       = azuread_application.ws[count.index].application_id
    ws_sp_client_secret   = azuread_service_principal_password.ws[count.index].value
    ws_storage_account    = azurerm_storage_account.ws[count.index].name
    ws_storage_container  = azurerm_storage_container.ws[count.index].name
    ws_access_key         = azurerm_storage_account.ws[count.index].primary_access_key
    ws_public_ip_name     = azurerm_public_ip.ws[count.index].name
    ws_public_ip_ip       = azurerm_public_ip.ws[count.index].ip_address
    ws_public_dns_name    = azurerm_dns_a_record.ws[count.index].name
    ws_public_dns_zone    = azurerm_dns_a_record.ws[count.index].zone_name
  }
}

resource "local_file" "ws" {
  count = length(var.users)

  sensitive_content = data.template_file.ws[count.index].rendered
  filename          = "${path.module}/output/${var.users[count.index].id}.conf"
}
