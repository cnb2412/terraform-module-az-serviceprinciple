data "azuread_user" "owners" {
  for_each = toset(var.owner_upns)
  user_principal_name = each.value
}

resource "azuread_application" "myapp" {
  display_name = var.display_name
  owners       = values(data.azuread_user.owners)[*].object_id
  description = var.description
}

resource "azuread_service_principal" "mysp" {
  client_id               = azuread_application.myapp.client_id
  app_role_assignment_required = false
  owners                       = values(data.azuread_user.owners)[*].object_id
  description = var.description
  account_enabled = var.account_enabled
}

# resource "azuread_service_principal_password" "az_sp_pwd" {
#     service_principal_id = azuread_service_principal.az_sp.object_id
#     display_name = "Az-DevOps_secret"
#     # end_date = "2023-10-01T01:02:03Z"
# }
