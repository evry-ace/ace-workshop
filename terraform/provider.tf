provider "azurerm" {
  subscription_id            = "${var.azure_subscription_id}"
  client_id                  = "${var.azure_client_id}"
  client_secret              = "${var.azure_client_secret}"
  tenant_id                  = "${var.azure_tenant_id}"
  version                    = "v1.33.0"
  skip_provider_registration = true
}

provider "kubernetes" {
  version = "v1.8.1"
  host    = "${module.aks.kube_host}"

  client_key             = "${base64decode(module.aks.kube_client_key)}"
  client_certificate     = "${base64decode(module.aks.kube_client_ca)}"
  cluster_ca_certificate = "${base64decode(module.aks.kube_cluster_ca)}"
}

provider "helm" {
  version         = "v0.10.2"
  install_tiller  = true
  service_account = kubernetes_service_account.tiller_sa.metadata[0].name

  kubernetes {
    host = "${module.aks.kube_host}"

    client_key             = "${base64decode(module.aks.kube_client_key)}"
    client_certificate     = "${base64decode(module.aks.kube_client_ca)}"
    cluster_ca_certificate = "${base64decode(module.aks.kube_cluster_ca)}"
  }
}

terraform {
  backend "azurerm" {
    container_name = "terraform-state"
    key            = "terraform.tfstate"
  }
}
