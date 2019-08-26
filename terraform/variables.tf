variable "user_id" {}
variable "azure_location" {}
variable "azure_resource_group" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "azure_subscription_id" {}
variable "aks_rbac_client_app_id" {}
variable "aks_rbac_server_app_id" {}
variable "aks_rbac_server_app_secret" {}
variable "aks_rbac_cluster_admins_group_id" {}
variable "aks_rbac_cluster_users_group_id" {}
variable "aks_ssh_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTMK+HzpmWf50Y7kbKR4YAWfLujeY7BGxBpVBd9eDA7SPT7bRYzlu2wn4kJVXPkrlNKD8Qd8CFLP6ABlXcBIopqhMrQ4FBNQBe4uVEQhfpFwcD54KDpXPROlK0ydBN527arvEOtdF+bJrxx5FWr2g4kCK+lLf0X5d2TZ1T/gd5ejpZbwzDxvJi5mJAj2kLQW2FUTWMwXoxrjJM/B6STxz7qRdlL5ljQIQ+klF0R6lpbh/2o2PMpe6bRrxt6lA3oNwBJFV0ZXJijAgdVmTL62v3ZYgkBrbFTe3sRFPI6i2s2LZzrSJB0gInRC0aLqxBZhWTBjH/Itml1LzYDQbNoGCT ekarlso@ekarlso-p1"
}
variable "aks_ingress_ip" {}
variable "aks_ingress_dns_name" {}
