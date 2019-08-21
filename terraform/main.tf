data "azurerm_resource_group" "ws-rg" {
  name = var.resource_group
}

module "acr" {
  source        = "github.com/evry-ace/tf-azure-acr"
  registry_name = "ace-ws-${var.name}"
  resource_group_name = data.azurerm_resource_group.ws-rg.name
}

module "aks" {
  source = "github.com/evry-ace/tf-azure-aks"
  cluster_name   = "ace-ws-${var.name}"
  resource_group_name = data.azurerm_resource_group.ws-rg.name

  rbac_server_app_id = var.rbac_server_app_id
  rbac_server_app_secret = var.rbac_server_app_secret
  rbac_client_app_id = var.rbac_client_app_id

  dns_prefix = "ace-ws-${var.name}"

  client_id = var.client_id
  client_secret = var.client_secret
  ssh_public_key = var.ssh_public_key
}