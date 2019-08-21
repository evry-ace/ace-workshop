data "azurerm_resource_group" "rg-ws" {
  name = var.resource_group
}

module "acr" {
  source              = "github.com/evry-ace/tf-azure-acr"
  registry_name       = "acews${var.name}"
  resource_group_name = data.azurerm_resource_group.rg-ws.name
  sku                 = "Standard"
}

resource "azurerm_log_analytics_workspace" "la-ws" {
  name                = "la-ws-${var.name}"
  resource_group_name = data.azurerm_resource_group.rg-ws.name
  location            = data.azurerm_resource_group.rg-ws.location
  sku                 = "PerGB2018"
}

module "aks" {
  source              = "github.com/evry-ace/tf-azure-aks"
  cluster_name        = "aks-ws-${var.name}"
  resource_group_name = data.azurerm_resource_group.rg-ws.name

  rbac_server_app_id     = var.aks_rbac_server_app_id
  rbac_server_app_secret = var.aks_rbac_server_app_secret
  rbac_client_app_id     = var.aks_rbac_client_app_id

  dns_prefix = "ace-ws-${var.name}"

  client_id      = var.client_id
  client_secret  = var.client_secret
  ssh_public_key = var.ssh_public_key

  oms_agent_enable = false
  oms_workspace_id = azurerm_log_analytics_workspace.la-ws.id

  k8s_version = "1.14.6"
}
