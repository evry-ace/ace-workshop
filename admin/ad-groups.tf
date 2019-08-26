data "azuread_group" "ace_users" {
  name = "ace--users"
}

data "azuread_group" "ace_admins" {
  name = "ace--admins"
}

data "azuread_user" "ws" {
  count = length(var.users)

  object_id = var.users[count.index].oid
}

resource "azuread_group_member" "ace_users" {
  count = length(var.users)

  group_object_id  = "${data.azuread_group.ace_users.id}"
  member_object_id = "${data.azuread_user.ws[count.index].id}"
}

resource "azuread_group_member" "ace_admins" {
  count = length(var.users)

  group_object_id  = "${data.azuread_group.ace_admins.id}"
  member_object_id = "${data.azuread_user.ws[count.index].id}"
}

resource "azurerm_role_assignment" "user-rg-ws" {
  count = length(var.users)

  scope                = "${data.azurerm_subscription.primary.id}/resourceGroups/${azurerm_resource_group.ws[count.index].name}"
  role_definition_name = "Owner"
  principal_id         = "${data.azuread_user.ws[count.index].id}"
}
