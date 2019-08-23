variable "azure_location" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "azure_subscription_id" {}
variable "azure_resource_group" {}

variable "users" {
  type = list(object({
    id    = string
    name  = string
    email = string
  }))

  default = [{
    id    = "e213794"
    name  = "Endre"
    email = "endre.karlson@evry.com"
  }]
}
