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

  default = [{
    id  = "hans"
    oid = "864c7087-d2a8-4ca8-84e0-f8c272d27311"
    }, {
    id  = "anders"
    oid = "e5bf60dc-749e-48c6-aa9e-a656ca47abfa"
    }, {
    id  = "daniel"
    oid = "6bd0d05d-f37e-49b9-a2cd-07e437dc5efc"
    }, {
    id  = "igor"
    oid = "85843441-5a38-4055-b67e-b1c97f4b94f9"
    }, {
    id  = "jimmy"
    oid = "d11ad384-1221-41e7-81c9-46c51d5095e3"
    }, {
    id  = "nicklas"
    oid = "7efd6afb-0ead-4865-8dda-2bb7f88902d6"
    }, {
    id  = "oystein"
    oid = "bb19d995-b8c0-4a6d-bd4c-32f6a65ef4de"
    }, {
    id  = "par"
    oid = "3ff40176-ddd9-4652-af2f-91bdc9c2834f"
    }, {
    id  = "rickard"
    oid = "dff5661f-9880-49ad-af8a-b05529be8498"
    }, {
    id  = "roger"
    oid = "ad0fffcb-4abc-4765-81e9-928418936296"
    }, {
    id  = "ronny"
    oid = "8992e341-b34a-416c-9646-6f86bf7dce2d"
    }, {
    id  = "steinar"
    oid = "b1f654ca-b374-4fa8-b8ea-a4836cdaf120"
    }, {
    id  = "viorica"
    oid = "4d2d1933-9ac4-46ae-b4a6-d6d2c00ea4bb"
    }, {
    id  = "olga"
    oid = "06c4e235-d9cb-4670-b85a-2ee218a37674"
    }, {
    id  = "shamrez"
    oid = "a95c02db-2eb8-43a9-939e-7d2d5a5824ed"
    }, {
    id  = "yen"
    oid = "7801a3f5-5db4-41f1-8e3a-4ec61365338e"
    }, {
    id  = "endre"
    oid = "88ebf85c-befc-47cf-acbb-b0062c5b039e"
  }]
}
