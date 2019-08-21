provider "azurerm" {
  subscription_id            = "${var.azure_subscription_id}"
  client_id                  = "${var.azure_client_id}"
  client_secret              = "${var.azure_client_secret}"
  tenant_id                  = "${var.azure_tenant_id}"
  version                    = "v1.32.1"
  skip_provider_registration = true
}

terraform {
  backend "azurerm" {
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}
