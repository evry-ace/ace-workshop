provider "azurerm" {
  subscription_id            = "${var.azure_subscription_id}"
  client_id                  = "${var.azure_client_id}"
  client_secret              = "${var.azure_client_secret}"
  tenant_id                  = "${var.azure_tenant_id}"
  version                    = "v1.33.0"
  skip_provider_registration = true
}

provider "azuread" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
  version         = "v0.6.0"
}

terraform {
  backend "azurerm" {
    container_name = "terraform-state"
    key            = "terraform.tfstate"
  }
}
