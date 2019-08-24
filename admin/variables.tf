variable "azure_location" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "azure_subscription_id" {}
variable "azure_resource_group" {}

variable "prefix" {
  default = "ace-workshop-2019"
}

variable "users" {
  type = list(object({
    id  = string
    oid = string
  }))

  default = [{
    id  = "hans"
    oid = "864c7087-d2a8-4ca8-84e0-f8c272d27311"
  }]
}
