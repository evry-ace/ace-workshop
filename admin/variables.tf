variable "azure_location" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "azure_subscription_id" {}
variable "azure_resource_group" {}
variable "aks_rbac_server_app_id" {}
variable "aks_rbac_server_app_secret" {}
variable "aks_rbac_client_app_id" {}

variable "prefix" {
  default = "ace-workshop-2019"
}

variable "users" {
  type = list(object({
    id  = string
    oid = string
  }))

  default = []
}
