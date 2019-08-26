data "azurerm_resource_group" "ws" {
  name = var.azure_resource_group
}

module "acr" {
  source                  = "github.com/evry-ace/tf-azure-acr"
  registry_name           = "aceworkshop2019${var.user_id}"
  resource_group_name     = data.azurerm_resource_group.ws.name
  resource_group_location = data.azurerm_resource_group.ws.location
  sku                     = "Standard"
}

resource "azurerm_log_analytics_workspace" "ws" {
  name                = "logs-ace"
  resource_group_name = data.azurerm_resource_group.ws.name
  location            = data.azurerm_resource_group.ws.location
  sku                 = "PerGB2018"
}

module "aks" {
  source                  = "github.com/evry-ace/tf-azure-aks"
  cluster_name            = "aks-ace"
  resource_group_name     = data.azurerm_resource_group.ws.name
  resource_group_location = data.azurerm_resource_group.ws.location

  rbac_server_app_id     = var.aks_rbac_server_app_id
  rbac_server_app_secret = var.aks_rbac_server_app_secret
  rbac_client_app_id     = var.aks_rbac_client_app_id

  dns_prefix = "ace"

  client_id      = var.azure_client_id
  client_secret  = var.azure_client_secret
  ssh_public_key = var.aks_ssh_public_key

  oms_agent_enable = false
  oms_workspace_id = azurerm_log_analytics_workspace.ws.id

  k8s_version = "1.14.6"
}

resource "kubernetes_cluster_role_binding" "ace_admins" {
  metadata {
    name = "ace-cluster-admins"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = var.aks_rbac_cluster_admins_group_id
  }
}
