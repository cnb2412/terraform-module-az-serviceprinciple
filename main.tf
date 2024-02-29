data "azuread_user" "owners" {
  for_each = toset(var.owner_upns)
  user_principal_name = each.value
}

resource "azuread_application" "myapp" {
  count = var.remove_sp ? 0 : 1
  display_name = var.display_name
  owners       = values(data.azuread_user.owners)[*].object_id
  description = var.description
}

resource "azuread_service_principal" "mysp" {
  count = var.remove_sp ? 0 : 1
  client_id               = azuread_application.myapp[0].client_id
  app_role_assignment_required = false
  owners                       = values(data.azuread_user.owners)[*].object_id
  description = var.description
  account_enabled = var.account_enabled
}

resource "azuread_service_principal_certificate" "cert" {
  count = !var.remove_sp && length(var.certificate) > 0 ? 1 : 0
  service_principal_id = azuread_service_principal.mysp[0].id
  type                 = "AsymmetricX509Cert"
  value                = var.certificate
  end_date_relative    = var.end_date_relative
}

# resource "azuread_service_principal_password" "az_sp_pwd" {
#     service_principal_id = azuread_service_principal.az_sp.object_id
#     display_name = "Az-DevOps_secret"
#     # end_date = "2023-10-01T01:02:03Z"
# }
