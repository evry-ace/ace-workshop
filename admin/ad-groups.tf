data "azuread_group" "ace_users" {
  name = "ace--users"
}

data "azuread_group" "ace_admins" {
  name = "ace--admins"
}
